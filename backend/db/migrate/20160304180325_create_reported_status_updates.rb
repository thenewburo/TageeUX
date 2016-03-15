class CreateReportedStatusUpdates < ActiveRecord::Migration
  def change
    create_table :reported_status_updates do |t|
      t.integer :status_update_id
      t.string :reason

      t.timestamps null: false
    end

    add_index :reported_status_updates, :status_update_id
  end
end
