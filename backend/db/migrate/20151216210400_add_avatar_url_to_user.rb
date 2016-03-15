class AddAvatarUrlToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.column :avatar_url, :string
    end
  end
end
