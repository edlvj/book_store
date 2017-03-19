module CustomFlashes
  
  def add_cart_failed
    #flash[:error] = t('smth_wrong_add_book')
    redirect_back(fallback_location: books_path)
  end
  
end  