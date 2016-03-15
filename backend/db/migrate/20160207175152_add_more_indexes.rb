class AddMoreIndexes < ActiveRecord::Migration
  def change    
    add_index :tag_status_updates, :tag_id
    add_index :tag_status_updates, :status_update_id
  end
end
