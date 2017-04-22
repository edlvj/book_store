module ApplicationHelper
  def price_in_currency(price)
    number_to_currency price, unit: '€'
  end
  
  def countries
    Country.order(:name).pluck(:name, :id)
  end  
end
