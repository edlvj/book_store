module Checkout
  class PaymentStep < Rectify::Command
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
      @errors = {}
    end
    
  def call
    if credit_card_form.valid? && create_card_update
      broadcast :valid
    else
      @errors[:credit_card] = @card_form
      broadcast :invalid, @errors
    end  
  end
  
  private
  
  def credit_card_form
    @card_form = CreditCardForm.from_params credit_card_attributes
  end  
  
  def credit_card_attributes
    @params[:order][:credit_card].merge(user_id: @user.id, order_id: @order.id)
  end

  def create_card_update
    @card = CreditCard.create credit_card_form.to_h
    @order.update_attribute(:credit_card_id, @card.id) 
  end
  end  
end