module TagCategoriesHelper
  def tag_categories_for_select user_tag_categories, tag
    user_tag_category_ids = user_tag_categories ? user_tag_categories.pluck(:tag_category_id) : []
    options_from_collection_for_select(TagCategory.all, :id, :name, user_tag_category_ids)
  end
end
