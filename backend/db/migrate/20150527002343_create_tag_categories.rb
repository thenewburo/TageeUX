class CreateTagCategories < ActiveRecord::Migration
  def change
    create_table :tag_categories do |t|
      t.string :name
      t.timestamps null: false
    end

    add_column :tags, :tag_category_id, :integer
  end
end
