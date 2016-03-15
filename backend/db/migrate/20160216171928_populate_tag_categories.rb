class PopulateTagCategories < ActiveRecord::Migration
  def change
    %w(Sports Politics Entertainment Technology Celebrities World News Social Justice Environment Health Finance Architecture/Art).each do |tag_category|
      TagCategory.create name: tag_category
    end
  end
end
