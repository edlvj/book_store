ActiveAdmin.register Order do
  permit_params :total_price, :aasm_state, :id, :confirmed_date

  filter :total_price
  filter :aasm_state, as: :select, collection: proc { Order.aasm.states_for_select }
  filter :confirmed_date

  actions :all

  index :as => ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :number, sortable: :id do |order|
      order.id
    end
    column :date_confirm, sortable: :confirmed_date do |order|
      order.confirmed_date
    end
    column :aasm_state, sortable: :aasm_state do |order|
      order.aasm_state
    end
    column :total_price, sortable: :total_price do |order|
      number_to_currency(order.total_price, unit: '€')
    end
    actions
  end
  
  form(:html => { :multipart => true }) do |f|
    f.input :aasm_state, label: 'Change state', as: :select, collection: order.aasm.states.map(&:name)
    f.actions
  end

end    