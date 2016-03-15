ActiveAdmin.register User do
  permit_params :title, :expires_at, :tag_category_id, :hidden
  # actions :all, only: [:view]
  actions :index, :show

  index do
    id_column
    column :screen_name
    column :created_at
    column :updated_at

    actions
  end
end
