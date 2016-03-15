class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
      t.string :identity, null: false
      t.string :provider, null: false
      t.string :media_uri
      t.timestamps null: false
    end
  end
end
