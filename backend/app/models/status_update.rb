class StatusUpdate < ActiveRecord::Base
  has_many :tag_status_updates
  has_many :tags, through: :tag_status_updates
  has_many :reported_status_updates, dependent: :destroy
end
