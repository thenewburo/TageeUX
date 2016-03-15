class UserTagCategoriesController < ApplicationController
  before_action :must_be_logged_in!
  before_filter :load_tag

  def create
    current_user.add_tag_categories(@tag, params[:user_tag_category][:tag_categories_ids])
    redirect_to tag_path(@tag)
  end

  private

  def load_tag
    @tag = Tag.find(params[:user_tag_category][:tag_id])
  end


end
