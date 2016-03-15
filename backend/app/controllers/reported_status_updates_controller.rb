class ReportedStatusUpdatesController < ApplicationController

  skip_before_filter :must_be_logged_in!

  def create
    reported_status = ReportedStatusUpdate.where(status_update_id: params[:status_update_id], reason: params[:reason]).first_or_create
    redirect_to :back, notice: 'Reported. Thanks!'
  end

end
