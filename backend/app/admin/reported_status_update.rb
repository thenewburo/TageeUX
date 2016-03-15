ActiveAdmin.register ReportedStatusUpdate do
  permit_params :status_update_id, :reason

  filter :reason
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      end_of_association_chain.includes(:status_update)
    end

    def remove_status_update
      report = ReportedStatusUpdate.find params[:id]
      report.status_update.destroy
      redirect_to collection_path
    end
  end

  member_action :remove_status_update, only: [:index, :show] do |report|
    link_to 'Remove media', admin_status_update_path(report.status_update), method: :delete
  end

  collection_action :remove_status_update, method: :delete do
    resource.status_update.destroy
    redirect_to collection_path, notice: "Status update removed"
  end

  index do
    id_column
    column :status_update do |report|
      link_to report.status_update.media_uri, target: '_blank' do
        if report.status_update.content_type == 'image'
          image_tag report.status_update.media_uri, size: '75x75'
        else
          video_tag report.status_update.media_uri, controls: true, size: '75x75'
        end
      end
    end
    column :reason

    actions

  end

  show do
    attributes_table do
      row :id
      row :status_update
      row :media do |report|
        if report.status_update.content_type == 'image'
          image_tag report.status_update.media_uri
        else
          video_tag report.status_update.media_uri, controls: true
        end
      end
      row :reason
      row :created_at
      row :updated_at
    end
  end

end
