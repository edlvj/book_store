module Checkout
  class PaymentStep < Rectify::Command
    def initialize(order, params, user)
      @order = order
      @params = params
      @user = user
    end
    
    def call
      if credit_card_form.valid? && create_card_update
        broadcast :valid
      else
        broadcast :invalid, credit_card: @card_form
      end  
    end
    
    private
    
    def credit_card_form
      @card_form = CreditCardForm.from_params credit_card_attributes
    end  
    
    def credit_card_attributes
      card_params = credit_card_params[:credit_card_attributes].to_h
      card_params.merge(user_id: @user.id)
    end
  
    def create_card_update
      if @order.credit_card.present?
        @card = CreditCard.find_by(number: @card_form.number)
        @card.update_attributes(@card_form.to_h.except(:id))
      else
        @card = CreditCard.new(@card_form.to_h.except(:id))
        @order.credit_card = @card
        @order.credit_card_id = @card.id
        @order.save
      end
    end
    
    def credit_card_params
      @params.require(:order).permit(credit_card_attributes: [:number, :name, :expiration_date, :cvv])
    end
  end  
end