module CheckoutHelper
  def is_step_active progress
    return "step active" if step == progress
    return "step done" if past_step?(progress)
    "step"
  end
  
  def countries
    Country.order(:name).pluck(:name, :id)
  end  
  
  def is_use_billing?
    return false if @billing_address[:firstname].nil?
    [:billing, :shipping].map do |type|
      instance_variable_set("@#{type}", eval("@#{type}_address").attributes.except('id', 'addressable_type', 'updated_at', 'created_at'))
    end
    @billing == @shipping
  end  
end
