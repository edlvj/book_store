class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :category_list
  
  def current_order
    @current_order ||= set_current_order
  end
  
  def checkout_login
    return if user_signed_in?
    redirect_to sign_in_path(:checkout) if :authenticate_user!
  end
  
  protected
  
  def set_current_order
    order = Order.find_by(id: session[:order_id], aasm_state: :in_progress)
    order ||= Order.create
    order = current_user.order_in_processing.set_order!(order) if current_user
    session[:order_id] = order.id
    order
  end
  
  def category_list
    @category_list = Category.select(:id, :name)
  end
end
