class AddHiddenAttributeToTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.boolean :hidden, null: false, default: false
    end
  end
end
