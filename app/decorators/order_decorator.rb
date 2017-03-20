class OrderDecorator < Drape::Decorator
  delegate_all
  
  def confirmed_at
    confirmed_date ? confirmed_date.strftime("%Y-%m-%d") : I18n.t('orders.not_confirmed')
  end 
  
  def total_sum
    total_price ? total_price : '0'
  end  
end