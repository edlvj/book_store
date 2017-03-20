class CheckoutController < ApplicationController
  include Wicked::Wizard
  
  before_action :checkout_login
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @shipping = Shipping.all
    ValidateStep.call(step, current_order) do
      on(:ok)       { render_wizard }
      on(:invalid)  { flash[:alert] = t('flash.failure.step')
                      redirect_to carts_path }
    end
  end
  
  def update
    UpdateCheckout.call(params, current_order, step) do
      on(:ok)            { redirect_to next_wizard_path }
      on(:invalid)       { render_wizard alert: t('flash.failure.step') }
      on(:validation)    { render_wizard }
    end
  end  
end
