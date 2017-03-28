class CreateReview < Rectify::Command
  attr_reader :user, :book, :params
  
  def initialize(options)
    @user = options[:user]
    @book = options[:book]
    @params = options[:params]
  end
  
  def call
    if review_form.valid? && create_review
      broadcast :valid, book
    else
      broadcast :invalid, review_form
    end
  end
  
  def review_form
    @review_form ||= ReviewForm.new(update_params)
  end
  
  def update_params
    params[:review].merge(user_id: user.id, book_id: @book.id)
  end
  
  private
  
  def create_review
    review_params = review_form.to_h
    Review.create(review_params)
  end
end  