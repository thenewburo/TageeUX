class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false
      t.text :body, null: false
      t.timestamps null: false
    end
  end
end
