class BookSort < Rectify::Query
  TYPES = [:newest, :popular, :price_hl, :price_lh, :title_asc, :title_desc]
  
  def initialize(sort, category, page = 1)
    @sort = sort 
    @category = category
    @page = page
  end
  
  def query
    @books = Book.all
    @books = self.by_category(@category) if @category
    @books= self.send(@sort) if @sort
    @books.page(@page)
  end  

  def newest
    @books.order(created_at: :desc)
  end

  def popular
    @books.joins(:order_items).order('order_items.qty desc')
  end
  
  def price_hl
    @books.order(price: :desc)
  end
  
  def price_lh
    @books.order(price: :asc) 
  end
  
  def title_asc
    @books.order(title: :asc)
  end
  
  def title_desc
    @books.order(title: :desc)
  end  
  
  def by_category(category)
    @books.joins(:category).where( 'lower(categories.name) = ?', category.downcase)
  end  
end