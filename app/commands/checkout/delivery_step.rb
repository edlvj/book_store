module Checkout
  class DeliveryStep < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end
    
    def call
      true if delivery_exist? && update_order
    end

    private

    def delivery_exist?
      Shipping.exists?(id: @params[:order][:shipping_id])
    end
     
    def update_order
      @order.update_attributes delivery_params
    end

    def delivery_params
      @params.require(:order).permit(:shipping_id)
    end
    
  end
end  