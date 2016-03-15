class AddContentTypeToStatusUpdates < ActiveRecord::Migration
  def change
    add_column :status_updates, :content_type, :text, default: 'image', nullable: false
  end
end
