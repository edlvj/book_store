module CheckoutHelper
  def is_step_active progress
    return "step active" if step == progress
    return "step done" if past_step?(progress)
    "step"
  end
  
  def countries
    Country.order(:name).pluck(:name, :id)
  end  
end
