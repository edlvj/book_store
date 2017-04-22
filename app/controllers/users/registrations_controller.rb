class Users::RegistrationsController < Devise::RegistrationsController
  include UserAddress
  include Rectify::ControllerHelpers
  
  before_action -> { set_addresses current_user }, only: [:edit, :update]
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def new
   super { return render 'users/sessions/checkout_login' if params[:type] == "checkout" }
  end

 def create
    if params[:type] == "checkout"
      generated_password = Devise.friendly_token.first(8)
      user = User.create(email: params[:user][:email], password: generated_password)
      RegistrationMailer.welcome(user, generated_password).deliver
      sign_in(:user, user)
      flash[:notice] = t("flash.success.checkout_login")
      redirect_to checkout_url(:address)
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
        flash[:notice] = t("flash.success.address_update")
        redirect_to setting_path
      end
      on(:invalid) do |errors|
        expose errors if errors
        flash[:alert] = t("flash.failure.address_update")
        render :edit
      end
    end
  end
  
  def update_user
    UpdateUser.call(current_user, params) do
      on(:valid) do
        flash[:notice] = t("flash.success.privacy_update")
        redirect_to setting_path
      end
      on(:invalid) do
        flash[:alert] = t("flash.failure.privacy_update")
        render :edit
      end
    end
  end
end
