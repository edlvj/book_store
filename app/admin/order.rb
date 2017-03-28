ActiveAdmin.register Order do
  permit_params :total_price, :aasm_state, :id, :confirmed_date

  filter :total_price
  filter :aasm_state, as: :select, collection: proc { Order.aasm.states_for_select }
  filter :confirmed_date

  actions :index, :show

  index :as => ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :number, sortable: :id do |order|
      order.id
    end
    column :date_confirm, sortable: :confirmed_date do |order|
      order.confirmed_date
    end
    state_column :aasm_state, sortable: :aasm_state, 
    states: { in_progres: "in_progres",  delivered: "approved", canceled: "rejected"} do |order|
      order.aasm_state
    end
    column :total_price, sortable: :total_price do |order|
      number_to_currency(order.total_price, unit: '€')
    end
    actions do |order|
      item link_to('In Devilery', admin_order_path(order, params.permit(:status).merge(state: :to_deliver)), method: :patch) if order.may_to_deliver?
      item link_to('Delivered ', admin_order_path(order, params.permit(:status).merge(state: :end_deliver)), method: :patch) if order.may_end_deliver?
      item link_to('Cancel', admin_order_path(order, params.permit(:status).merge(state: :cancel)), method: :patch) if order.may_cancel?
    end
  end

  controller do
    def update
      order = Order.find(params[:id])
      order.send("#{params['state']}!")
      redirect_back(fallback_location: root_path)
    end
  end
end    