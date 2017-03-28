class UpdateAddress < Rectify::Command
  attr_reader :user, :params
  
  def initialize(user, params)
    @user = user
    @params = params.permit!
    @errors = {}
    @billing = Address.where(user_id: @user.id, addressable_type: 'billing_address').first || Address.new
    @shipping = Address.where(user_id: @user.id, addressable_type: 'shipping_address').first || Address.new
  end
  
  def call
    if check_address && addresses_update
      broadcast :valid 
    else
      broadcast :invalid, @errors
    end
  end
  
  def check_address
    if @params[:address][:billing_address].present?
      @billing_address = AddressForm.new(billing_params) 
      @billing_address.valid? 
      @errors[:billing_address] = @billing_address
      return true
    end   
     
    if @params[:address][:shipping_address]
      @shipping_address = AddressForm.new(shipping_params)
      @shipping_address.valid?
      @errors[:shipping_address] = @shipping_address
      return true
    end  
  end 

  def addresses_update
    return set_address(billing_params) if @params[:address][:billing_address].present?
    return set_address(shipping_params) if @params[:address][:shipping_address].present?
  end

  def billing_params
    @params[:address][:billing_address].merge({user_id: @user.id, addressable_type: 'billing_address'})
  end

  def shipping_params
    @params[:address][:shipping_address].merge({user_id: @user.id, addressable_type: 'shipping_address'})
  end

  def set_address(type)
    @address_type = AddressForm.new(type).to_h.except(:id)
    return @billing.update_attributes(@address_type) if type == billing_params
    return @shipping.update_attributes(@address_type) if type == shipping_params  
  end
end  