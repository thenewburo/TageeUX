class UserTagCategory < ActiveRecord::Base

  belongs_to :user
  belongs_to :tag
  belongs_to :tag_category

  def self.refresh_top_category(tag)
    hash =  Hash.new(0)
    tag.user_tag_categories.each do |utc|
      hash[utc.tag_category_id] += 1
    end

    return if hash.empty?

    max_tag_category = TagCategory.find hash.max_by{ |k,v| v }.first
    tag.update(tag_category: max_tag_category) unless tag.tag_category == max_tag_category
  end
end
