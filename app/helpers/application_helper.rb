module ApplicationHelper
  
  def price_in_currency(price)
    number_to_currency price, unit: '€'
  end
  
  def edit_link(type)
    link_to I18n.t('checkout.edit'), checkout_path(type)
  end 
  
  def parse_error(obj, field)
    obj.errors.messages[field].first
  end
  
  def add_errors(obj, err_obj, type)
    err_obj.errors.each do |field|
      obj.errors[field] = err_obj.errors[field]
    end
  end  
end
