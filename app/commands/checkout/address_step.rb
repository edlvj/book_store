module Checkout
  class AddressStep < Rectify::Command
    include ApplicationHelper
    
    def initialize(order, params, user)
      @order = order
      @params = params.permit!
      @user = user
    end
    
    def call
      if validate_addresess && create_addresses
        true
      else
        add_errors(@order, @billing, :billing_address)
        add_errors(@order, @shipping, :shipping_address)
      end
    end
    
    private
    
    def validate_addresess
      @billing = AddressForm.new(billing_params)
      @shipping = AddressForm.new(shipping_params)
      @billing.valid? && @shipping.valid?
    end 
    
    def create_addresses
      set_address(billing_params) && set_address(shipping_params)
    end

    def billing_params
      @params[:order][:billing_address].merge( {user_id: @user.id, order_id: @order.id, addressable_type: 'billing_address'})
    end
    
    def shipping_params
      @shipp = @params[:use_billing] ? @params[:order][:shipping_address] : @params[:order][:billing_address]
      @shipp.merge(user_id: @user.id, order_id: @order.id, addressable_type: 'shipping_address')
    end
    
    def set_address(type)
     @address_type = AddressForm.new(type).to_h
     @addr = Address.new @address_type
     @addr.save
    end  
    
  end
end