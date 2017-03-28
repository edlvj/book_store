class Users::RegistrationsController < Devise::RegistrationsController
  include Rectify::ControllerHelpers
  
  before_action :set_address, only: [:edit, :update]
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def edit
    super
  end

  def update
    update_user if params[:user]
    update_address if params[:address]
  end
  
  def destroy
    if params[:agree]
      super
    else
      redirect_to setting_path, alert: t('flash.failure.confirm_terms')
    end    
  end
  
  private
  
  def update_address
    UpdateAddress.call(current_user, params) do
      on(:valid) do
        redirect_to setting_path, notice: t("flash.success.address_update")
      end
      on(:invalid) do |errors|
        expose errors if errors
        #raise errors.inspect
        flash[:alert] = t("flash.failure.address_update")
        render :edit
      end
    end
  end
  
  def update_user
    UpdateUser.call(current_user, params) do
      on(:valid) do
        redirect_to setting_path(anchor: :privacy), notice: t("flash.success.privacy_update")
      end
      on(:invalid) do
        flash_render :edit, alert: t("flash.failure.privacy_update")
      end
    end
  end 
  
  def set_address
    @address = Address.find_by(user_id: current_user.id) || Address.new
    @billing_address = Address.where(user_id: current_user.id, addressable_type: 'billing_address').first
    @shipping_address = Address.where(user_id: current_user.id, addressable_type: 'shipping_address').first
  end  
end
