class AddExpiresAtToTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.datetime "expires_at", null: false, default: Time.at(0)
    end
  end
end
