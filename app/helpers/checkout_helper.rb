module CheckoutHelper
  def is_step_active progress
    return "step active" if step == progress
    return "step done" if past_step?(progress)
    "step"
  end

  def is_use_billing?
    session['use_billing']
  end
  
  def edit_link(type)
    link_to I18n.t('checkout.edit'), checkout_path(type)
  end 
  
  def parse_errors(model)
    model.errors.full_messages.join('. ') if model.errors.present?
  end  
end
