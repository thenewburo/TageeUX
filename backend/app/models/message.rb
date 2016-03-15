class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :tag

  scope :in_order, -> { order('id asc') }
  scope :after, ->(id) { where('id > ?', id) }

  validates :body, presence: true, length: { maximum: 350 }
  validates :user, presence: true
  validates :tag, presence: true

end
