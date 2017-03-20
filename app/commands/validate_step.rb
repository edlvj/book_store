class ValidateStep < Rectify::Command
  def initialize(step, order)
    @step = step
    @order = order
  end
  
  def call
    return broadcast(:invalid) unless @step && @order
    ability_for(@step) ? broadcast(:ok) : broadcast(:invalid)
  end
  
  private
  
  def ability_for step
    case step
      when :address  then true
      when :delivery then delivery_able?
      when :payment  then payment_able?
      when :confirm  then confirm_able?
      when :complete then complete_able?
      else
        false
    end
  end
  
  def delivery_able?
    @order.order_billing && @order.order_shipping
  end
  
  def payment_able?
    delivery_able? &&  @order.shipping.present?
  end

  def confirm_able?
    payment_able? && @order.credit_card.present?
  end

  def complete_able?
    return true if @order.items_count.zero?
    confirm_able?
  end
end  