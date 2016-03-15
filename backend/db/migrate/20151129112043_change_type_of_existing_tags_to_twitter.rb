class ChangeTypeOfExistingTagsToTwitter < ActiveRecord::Migration
  def change
    Tag.find_each do |tag|
      tag.becomes(TwitterTag)
      tag.type = "TwitterTag"
      tag.save!
    end
  end
end
