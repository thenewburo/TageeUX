class CreateTagStatusUpdates < ActiveRecord::Migration
  def change
    create_table :tag_status_updates do |t|
      t.integer :status_update_id, null: false
      t.integer :tag_id, null: false
      t.timestamps null: false
    end
  end
end
