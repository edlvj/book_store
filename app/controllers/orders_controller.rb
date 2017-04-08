class OrdersController < ApplicationController
  load_and_authorize_resource through: :current_user
  
  def index
    @states = Order.aasm_states
    @orders = @orders.where(aasm_state: params[:state]) if params[:state]
  end
end
