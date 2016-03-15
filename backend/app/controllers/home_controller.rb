class HomeController < ApplicationController
  before_action :visit_tags, if: -> { logged_in? }, only: [:index]
  skip_before_filter :must_be_logged_in!, only: :index

  def index
    @user = User.new
    @tags = Tag.displayable.recently_active.limit(10)
  end

  protected

  def visit_tags
    redirect_to :tags
  end
end
