class RenameTagCategories < ActiveRecord::Migration
  def change
    TagCategory.where(name: 'Entertainment').first.update name: '#Itslit (Entertainment)'
    TagCategory.where(name: 'Politics').first.update name: '#Handsupdontshoot (Politics)'
    ["#DownintheDM (Sex/Relationships)", "#Chattypatty (General)", "#Sipthistea (Gossip)", "#Netflixandchill (Movies)", "#YeezyYeezy (Fashion)", "#Lookatmydab (Music/Dance)"].each do |tag_category|
      TagCategory.create name: tag_category
    end

    general_tag = TagCategory.where(name: '#Chattypatty (General)').first

    old_tag_ids = TagCategory.where(name: ["Architecture/Art", "Celebrities", "Environment", "Finance", "Health", "Justice", "News", "Social", "Sports", "Technology", "World"]).pluck :id
    Tag.where(tag_category_id: old_tag_ids).update_all tag_category_id: general_tag.id
    UserTagCategory.where(tag_category_id: old_tag_ids).update_all tag_category_id: general_tag.id

    TagCategory.where(id: old_tag_ids).destroy_all
  end
end
