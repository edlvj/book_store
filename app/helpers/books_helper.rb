module BooksHelper
  def last_path_helper
    request.env['HTTP_REFERER'] || books_path
  end
  
  def books_count
    Book.all.count
  end  
end
