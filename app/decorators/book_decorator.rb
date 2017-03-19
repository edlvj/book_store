class BookDecorator < Drape::Decorator
  include ActionView::Helpers
  delegate_all
  decorates_association :author

  def author_name
    object.author.map(&:first_name).to_sentence
  end  
   
  def price_in_currency
    h.number_to_currency price, :unit=>'€'
  end
  
  def short_description
    truncate description, length: 200
  end  

end   