class TagCategoriesController < ApplicationController

  before_filter :require_admin!, except: [:show]

  def index
    @categories = TagCategory.all
  end

  def new
    @category = TagCategory.new
  end


  def show
    @tag_category = TagCategory.find params[:id]
    tags = @tag_category.tags.not_expired.displayable.has_media
    @status_updates = tags.map do |tag|
      tag.status_updates.limit(5)
    end.flatten
  end

  def create
    TagCategory.create!(tag_category_params)
    redirect_to :tag_categories
  rescue ActiveRecord::RecordInvalid => e
    @category = e.record
    render :new
  end

  private

  def tag_category_params
    params.require(:tag_category).permit(:name)
  end

end
