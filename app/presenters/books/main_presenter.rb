module Books
  class MainPresenter
    attr_reader :params
  
    def initialize(params)
      @params = params
    end

    def books
      @books ||= books_query
    end  
    
    def sort_types
      @sort_types ||= Book::SORT_TYPES
    end
    
    private
    
    def books_query
      Book.sorting_by(params[:sort]).by_category(params[:category]).page(params[:page])
    end  
  end
end