module Checkout
  class DeliveryStep < Rectify::Command
    def initialize(order, params, user = nil)
      @order = order
      @params = params
    end
    
    def call
      if delivery_exist? && update_order
        broadcast :valid
      else
        broadcast :invalid
      end    
    end

    private

    def delivery_exist?
      Shipping.exists?(id: @params[:shipping_id])
    end
     
    def update_order
      @order.update_attribute(:shipping_id, @params[:shipping_id]) 
    end

    def delivery_params
      @params.permit(:shipping_id)
    end
  end
end  