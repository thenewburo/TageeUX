ActiveAdmin.register StatusUpdate do

  filter :provider
  filter :identity
  filter :content_type
  filter :created_at
  filter :updated_at

  index do
    id_column
    column :provider
    column :identity
    column :content_type
    column :preview do |status|
      link_to status.media_uri, target: '_blank' do
        if status.content_type == 'image'
          image_tag status.media_uri, size: '75x75'
        else
          video_tag status.media_uri, controls: true, size: '75x75'
        end
      end
    end
    column :tag do |status|
      status.tags.first.title
    end

    column :created_at
    column :updated_at

    column :tag_expires_at do |status|
      status.tags.first.expires_at
    end

    actions
  end


  show do
    attributes_table do
      row :id
      row :identity
      row :provider
      row :media_uri
      row :created_at
      row :updated_at
      row :content_type
      row :media do |status_update|
        if status_update.content_type == 'image'
          image_tag status_update.media_uri
        else
          video_tag status_update.media_uri, controls: true
        end
      end
    end
  end
end
