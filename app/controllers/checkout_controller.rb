class CheckoutController < ApplicationController
  include UserAddress
  include Wicked::Wizard
  include Rectify::ControllerHelpers
 
  before_action :checkout_login
  before_action -> { set_addresses current_user }, :set_payment, only: [:show, :update]
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @shipping = Shipping.all
    Checkout::ValidateStep.call(step, current_order) do
      on(:ok)       { render_wizard }
      on(:invalid)  { flash[:alert] = t('flash.failure.step')
                      redirect_to checkout_path(previous_step) }
    end
  end
  
  def update
    session['use_billing'] = params[:use_billing] if params[:use_billing] == "true"
    "Checkout::#{step.capitalize}Step".constantize.call(current_order, params, current_user) do
      on(:valid) do
        return redirect_to checkout_path(:confirm) if confirm_redirect?
        redirect_to next_wizard_path 
      end
      on(:invalid) do |errors|  
        expose errors if errors
        render_wizard 
      end
    end  
  end
  
  private
  
  def set_payment
    @credit_card = CreditCard.find_by(order_id: current_order.id) || CreditCard.new
  end
  
  def confirm_redirect?
    next_step != :complete && Checkout::ValidateStep.new(:confirm, current_order).ability_for(:confirm)
  end
end
