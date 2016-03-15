class MessagesController < ApplicationController

  before_action :must_be_logged_in!, only: [:create]
  before_action :load_tag

  def index
    @messages = @tag.messages.in_order.after(params[:after])
  end

  def create
    @tag.messages.create!(message_params.merge(user: current_user))
    @tag.update_expires_at!
    render nothing: true, status: 204
  end

  private

  def load_tag
    @tag = Tag.find(params[:tag_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

end
