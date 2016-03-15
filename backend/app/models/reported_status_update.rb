class ReportedStatusUpdate < ActiveRecord::Base
  belongs_to :status_update

  validates_presence_of :status_update_id, :reason

end
