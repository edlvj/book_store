class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

   def facebook
    @checkout_type = request.env["omniauth.params"]["checkout"]  
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @checkout_type
        sign_in(:user, @user)
        redirect_to checkout_path(:address), :event => :authentication 
      else
        sign_in_and_redirect @user, :event => :authentication
      end
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def failure
    redirect_to root_path
  end
end
