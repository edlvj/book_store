module Books
  class CatalogPresenter
    attr_reader :params
  
    def initialize(params)
      @params = params
    end

    def books
      @books ||= books_query
    end  
    
    def sort_types
      @sort_types ||= BookSort::TYPES
    end
    
    private
    
    def books_query
      BookSort.new(params[:sort], params[:category], params[:page]).query
    end  
  end
end