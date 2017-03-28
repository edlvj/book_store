class CheckoutController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  
  before_action :checkout_login
  before_action :set_address, :set_payment, only: :show
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @shipping = Shipping.all
    Checkout::ValidateStep.call(step, current_order) do
      on(:ok)       { render_wizard }
      on(:invalid)  { flash[:alert] = t('flash.failure.step')
                      redirect_to carts_path }
    end
  end
  
  def update
    "Checkout::#{step.capitalize}Step".constantize.call(current_order, params, current_user) do
      on(:valid)            { redirect_to next_wizard_path }
      on(:invalid) do |errors|  
        expose errors if errors
        render_wizard 
      end
    end
  end
  
  private
  
  def set_address
    @billing_address = Address.where(order_id: current_order.id, addressable_type: 'billing_address').first
    @shipping_address = Address.where(order_id: current_order.id, addressable_type: 'shipping_address').first
  end 
  
  def set_payment
    @credit_card = CreditCard.find_by(order_id: current_order.id)
  end  
end
