class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :uid, null: false
      t.string :auth_token
      t.string :auth_secret
      t.integer :user_id, null: false
      t.timestamps null: false
    end

    add_index :services, :user_id, unique: false
  end
end
