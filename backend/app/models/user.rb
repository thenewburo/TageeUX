class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable

  has_many :services
  has_many :messages
  has_many :active_tags, -> { order("created_at DESC").limit(1) },
    through: :messages, source: 'tag'
  has_many :user_tag_categories

  validates :screen_name, presence: true, uniqueness: true

  before_validation :set_screen_name_as_email, :set_filler_info

  def last_active_tag
    active_tags.first
  end

  def add_tag_categories tag, tag_categories_ids
    self.user_tag_categories.where.not(tag_category_id: tag_categories_ids.delete_if(&:blank?)).destroy_all
    TagCategory.where(id: tag_categories_ids).each do |tag_category|
      tag_category = self.user_tag_categories.where(user_id: self.id, tag: tag, tag_category_id: tag_category.id).first_or_create
    end
    UserTagCategory.refresh_top_category tag
  end

  private

  def set_screen_name_as_email
    return if self.services.any?
    self.screen_name ||= email
  end

  # email is not required for user logged in by a social network
  def email_required?
    self.services.empty?
  end

  def set_filler_info
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0...10).map { o[rand(o.length)] }.join
    self.password = string unless self.password.present?
  end
end
