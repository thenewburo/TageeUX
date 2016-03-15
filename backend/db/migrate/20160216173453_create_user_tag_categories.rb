class CreateUserTagCategories < ActiveRecord::Migration
  def change
    create_table :user_tag_categories do |t|
      t.integer :user_id
      t.integer :tag_category_id
      t.integer :tag_id

      t.timestamps null: false
    end
    add_index :user_tag_categories, :user_id
    add_index :user_tag_categories, :tag_id
    add_index :user_tag_categories, :tag_category_id
  end
end
