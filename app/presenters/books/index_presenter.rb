module Books
  class IndexPresenter
    attr_reader :category
   
    def initialize(params)
      @category = params[:category]
    end   

    def lastest
      BookSort.new(:newest, category).query.take(3)
    end
    
    def bestsellers
      BookSort.new(:popular, category).query.take(4)
    end 

    def category
      @category ||= Category::DEFAULT
    end    
  end
end