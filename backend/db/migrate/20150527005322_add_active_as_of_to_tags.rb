class AddActiveAsOfToTags < ActiveRecord::Migration
  def change
    add_column :tags, :active_as_of, :timestamp
    add_index :tags, :active_as_of
  end
end
