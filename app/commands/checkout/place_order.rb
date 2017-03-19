module Checkout
  class PlaceOrder < Rectify::Command
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
    end
    
    def call
      return false if @user.blank? && @order.blank?
      transaction do
        @order.queued!
        @order.update_attribute(:confirmed_date, DateTime.now)
        @order.update_attribute(:total_price, @order.total_cost)
        send_to_mail
      end 
    end  
    
    def send_to_mail
      ConfirmMailer.complete(@user, @order).deliver
    end
  end  
end    