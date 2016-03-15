class AddIndexesToCommonFields < ActiveRecord::Migration
  def change
    add_index :tag_status_updates, [:tag_id, :status_update_id]

    add_index :tags, :hidden

    add_index :messages, [:tag_id, :user_id]
    add_index :messages, :tag_id
    add_index :messages, :user_id
  end
end
