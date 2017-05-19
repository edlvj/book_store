module Checkout
  class AddressStep < Rectify::Command
    include UserAddress
    
    def initialize(order, params, user)
      @order = order
      @user = user
      @params = params
      local_params = { user_id: user.id }
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
      [:billing, :shipping].map do |address|
        if eval("@order.order_#{address}") != nil
          eval("@order.order_#{address}.update_attributes(@#{address}.to_h.except(:id))")
        else
          @address = eval("Address.new(@#{address}.to_h.except(:id))")
          eval("@order.order_#{address} = @address")
          @order.save
        end
      end
    end
  end
end