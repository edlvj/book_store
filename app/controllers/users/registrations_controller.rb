class Users::RegistrationsController < Devise::RegistrationsController

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def edit
   # @billing = current_user.user_billing
   # @shipping = current_user.user_shipping
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
    UpdateAddress.call(addressable: current_user, params: params) do
      on(:valid) do
        #success_update('address')
      end
      on(:invalid) do |addresses|
        expose addresses
       # failure_update('address')
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

end
