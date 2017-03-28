module ApplicationHelper
  
  def price_in_currency(price)
    number_to_currency price, unit: '€'
  end
  
  def edit_link(type)
    link_to I18n.t('checkout.edit'), checkout_path(type)
  end 

  def parse_error(obj, field)
    obj.errors.full_messages_for(field).first
  end
end
