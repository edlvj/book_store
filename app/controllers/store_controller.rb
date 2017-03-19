class StoreController < ApplicationController
  before_action :set_category, only: :index
  
  def index
    @latests = Book.by_category(@category).latests
    @bestsellers = Book.by_category(@category).bestsellers.limit(4)
  end
  
  private 
  def set_category
    @category = params[:category] || Category::DEFAULT
  end
end
