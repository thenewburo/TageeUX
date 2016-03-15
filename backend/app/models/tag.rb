class Tag < ActiveRecord::Base

  belongs_to :tag_category

  has_many :messages
  has_many :tag_status_updates, dependent: :destroy
  has_many :status_updates, through: :tag_status_updates, dependent: :destroy
  has_many :user_tag_categories

  scope :not_expired, -> { where('tags.expires_at > ?', DateTime.current) }
  scope :for_network, ->(network) {
    if network.present?
      where(type: "#{network.capitalize}Tag")
    else
      where("type IS NOT NULL")
    end
  }
  scope :has_media, -> {
    includes(:status_updates)
    .references(:status_updates)
    .where("status_updates.id IS NOT NULL")
  }
  scope :not_hidden, -> {
    where(hidden: false)
  }
  scope :displayable, -> {
    not_expired.merge(not_hidden)
  }
  scope :recently_active, -> {
    order('active_as_of DESC')
  }

  scope :has_active_conversation, -> {
    query = Tag.select(:id).joins(:messages)
      .group('messages.user_id, tags.id')
      .having('COUNT(messages.user_id) > 0')
    where(id: query)
  }

  before_save :update_expires_at

  # Advances expires_at by 12 hours past active_as_of if people are chatting
  # about this tag. No effect if expires_at 12+ hours away
  # Returns expires_at
  def update_expires_at
    if messages.count("DISTINCT user_id") >= 5
      self.expires_at = [active_as_of + 12.hours, expires_at].max
    end
    self.expires_at
  end

  # Calls #update_expires_at and then #save!
  def update_expires_at!
    update_expires_at
    save!
  end
end
