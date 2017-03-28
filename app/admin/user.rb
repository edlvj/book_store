ActiveAdmin.register User do
  permit_params :email
  
  index :as => ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :email, sortable: :email do |user|
      user.email
    end
    column :provider, sortable: :provider do |user|
      user.provider
    end
    actions
  end
  
  actions :index, :show
end
