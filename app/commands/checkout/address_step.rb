module Checkout
  class AddressStep < Rectify::Command
    include UserAddress
    
    def initialize(order, params, user)
      @order = order
      @user = user
      @params = params.permit!
      local_params = { user_id: user.id, order_id: order.id }
      set_params(params[:order], local_params, params[:use_billing])
      set_addresses(user)
    end
    
    def call
      if addresses_valid? && addresses_update
        broadcast :valid 
      else
        broadcast :invalid, addresses_errors
      end
    end
    
    private
    
    def addresses_errors
      [@billing, @shipping].map { |address| [ address.addressable_type, address] }.to_h
    end
  
    def addresses_valid?
      [@billing, @shipping].map(&:valid?).all?
    end
    
    def addresses_update
      [@billing, @shipping].map do |address|
        eval("@#{address.addressable_type}").update_attributes(address.to_h.except(:id))
      end
    end
 
  end
end