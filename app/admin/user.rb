ActiveAdmin.register User do
  permit_params :email
  actions :index, :show
end
