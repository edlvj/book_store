class UpdateUser < Rectify::Command
  attr_reader :user, :params
  
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    if update_user_info
      broadcast :valid
    else
      broadcast :invalid
    end
  end
  
  private
  
  def update_user_info
    return @user.update_with_password user_params if @params[:user][:password]
    @user.update_without_password user_params
  end
  
  def user_params
    @params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password)
  end
end  