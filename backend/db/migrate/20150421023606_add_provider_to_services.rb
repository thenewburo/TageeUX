class AddProviderToServices < ActiveRecord::Migration
  def change
    add_column :services, :provider, :string
    add_index :services, [:provider, :uid], unique: false
  end
end
