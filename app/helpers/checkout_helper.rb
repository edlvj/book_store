module CheckoutHelper
  def is_step_active progress
     step == progress ? "step active" : "step"
  end
end
