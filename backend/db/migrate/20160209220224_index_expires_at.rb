class IndexExpiresAt < ActiveRecord::Migration
  def change
    add_index :tags, :expires_at
  end
end
