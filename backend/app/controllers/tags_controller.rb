class TagsController < ApplicationController
  # before_action :must_be_logged_in!

  before_filter :require_admin!, :only => [:edit, :update]
  before_filter :load_tag, :only => [:edit, :update, :show]

  def index
    @tags = Tag.for_network(@network).displayable.recently_active.limit(20)

    @tags_by_category = @tags.group_by(&:tag_category).sort_by { |k, v| k.try(:name) || '' }
  end

  def edit
  end

  def update
    @tag.update_attributes!(tag_params)
    redirect_to @tag
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def show
    @user_tag_categories = current_user.user_tag_categories.where(tag_id: @tag.id) if current_user
    @tag.increment! :views, 1
    @chatroom_users = @tag.messages.select(:user_id)
      .group(:user_id)
      .includes(:user)
      .map(&:user)
  end

  def search
    # Simple fulltext search. Let's move to RSolr later.
    @tags = Tag.where('title LIKE ?', "%#{params[:tag]}%")
    render action: :index
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_category_id)
  end

  def load_tag
    @tag = Tag.find(params[:id])
  end

end
