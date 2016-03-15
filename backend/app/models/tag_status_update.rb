class TagStatusUpdate < ActiveRecord::Base
  belongs_to :tag
  belongs_to :status_update, dependent: :destroy
end
