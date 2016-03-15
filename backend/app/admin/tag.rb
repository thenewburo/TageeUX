ActiveAdmin.register Tag do
  permit_params :title, :expires_at, :tag_category_id, :hidden

  actions :all, except: [:destroy]

  filter :tag_category
  filter :title
  filter :count
  filter :views
  filter :hidden
  filter :created_at
  filter :active_as_of
  filter :expires_at

  controller do
    def scoped_collection
      end_of_association_chain.includes(tag_status_updates: :status_update)
    end
  end

  index do
    id_column
    column :title
    column :created_at
    column :active_as_of
    column :expires_at
    column :count
    column :views
    column :hidden
    column :media_count do |tag|
      tag.status_updates.count
    end


    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      input :title
      input :active_as_of, as: :datetime_select, start_year: Date.today.year, end_year: Date.today.year+1, include_blank: false, value: DateTime.now
      input :expires_at, as: :datetime_select, start_year: Date.today.year, end_year: Date.today.year+1, include_blank: false, value: DateTime.now
      input :tag_category
      input :hidden
    end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
