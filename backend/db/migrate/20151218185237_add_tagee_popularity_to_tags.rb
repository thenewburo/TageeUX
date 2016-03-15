class AddTageePopularityToTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.integer :views, null: false, default: 0
    end
  end
end
