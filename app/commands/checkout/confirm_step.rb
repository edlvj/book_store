module Checkout
  class ConfirmStep < Rectify::Command
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
    end
    
    def call
      return broadcast :invalid if @user.blank? || @order.blank?
      transaction do
        @order.queued!
        @order.update_attributes(confirmed_date: DateTime.now, total_price: @order.total_cost)
        send_to_mail
      end 
      broadcast :valid
    end  
    
    private
    
    def send_to_mail
      ConfirmMailer.complete(@user, @order).deliver
    end
  end  
end    