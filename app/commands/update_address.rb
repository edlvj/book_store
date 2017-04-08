class UpdateAddress < Rectify::Command
  include UserAddress
  attr_reader :user, :params
  
  def initialize(user, params)
    @user = user
    @params = params.permit!
    local_params = { user_id: user.id }
    set_params(params[:address], local_params)
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
    [curr_address].map { |address| [ address.addressable_type, address] }.to_h
  end

  def addresses_valid?
    [curr_address].map(&:valid?).all?
  end
  
  def addresses_update
    [curr_address].map do |address|
      eval("@#{address.addressable_type}").update_attributes(address.to_h.except(:id))
    end
  end
  
  def curr_address
    @curr_address = @params[:address][:billing_address] ? @billing : @shipping
  end  
end  