class ConfirmMailer < ApplicationMailer 
  def complete(user, order)
    @user = user
    @order = order
    mail to: @user.email, subject: "Complete Order ##{@order.id}"
  end
end  
  