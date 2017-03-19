class UpdateCheckout < Rectify::Command
  attr_reader :order, :params, :step
  
  def initialize(params, order, step)
    @params = params
    @order = order
    @step = step
  end
  
  def call
    return broadcast(:invalid) unless @params && @order
    transaction do
      case @step
        when :address  then Checkout::AddressStep.call(@order, @params, current_user)
        when :delivery then Checkout::DeliveryStep.call(@order, @params)
        when :payment  then Checkout::PaymentStep.call(@order, @params, current_user)
        when :confirm  then Checkout::PlaceOrder.call(@order, @params, current_user)
      end
    end
    @order.errors.any? ? broadcast(:validation) : broadcast(:ok)
  end

end  