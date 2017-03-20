module Checkout
  class PaymentStep < Rectify::Command
    include ApplicationHelper
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
    end
    
  def call
    if credit_card_form.valid? && create_card
      true
    else
      add_errors(@order, @card_form, :credit_card)
    end  
  end
  
  private
  
  def credit_card_form
    @card_form = CreditCardForm.from_params credit_card_params
  end  
  
  def credit_card_params
    @params[:order][:credit_card].merge(user_id: @user.id, order_id: @order.id)
  end

  def create_card
    @card = CreditCard.create credit_card_form.to_h
    @order.update_attribute(:credit_card_id, @card.id) 
  end
  end  
end