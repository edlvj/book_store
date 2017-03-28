module Checkout
  class AddressStep < Rectify::Command
    
    def initialize(order, params, user)
      @order = order
      @params = params.permit!
      @user = user
      @billing = Address.where(user_id: user.id, addressable_type: 'billing_address').first || Address.new
      @shipping = Address.where(user_id: user.id, addressable_type: 'shipping_address').first || Address.news
      @errors = {}
    end
    
    def call
      if check_address && addresses_update
        broadcast :valid 
      else
        @errors[:billing_address] = @billing_address
        @errors[:shipping_address] = @shipping_address
        broadcast :invalid, @errors
      end
    end
    
    private
    
    def check_address
      @billing_address = AddressForm.new(billing_params)
      @shipping_address = AddressForm.new(shipping_params)
      [@billing_address, @shipping_address].compact.all?(&:valid?)
    end 
    
    def addresses_update
      set_address(billing_params) && set_address(shipping_params)
    end

    def billing_params
      @params[:order][:billing_address].merge({user_id: @user.id, order_id: @order.id, addressable_type: 'billing_address'})
    end
    
    def shipping_params
      @shipp = @params[:use_billing] == 'true' ? @params[:order][:billing_address] : @params[:order][:shipping_address]
      @shipp.merge({user_id: @user.id, order_id: @order.id, addressable_type: 'shipping_address'})
    end
  
    def set_address(type)
      @address_type = AddressForm.new(type).to_h.except(:id)
      @shipping.update_attributes(@address_type) && @billing.update_attributes(@address_type)
    end 
  end
end