class ReviewForm < Rectify::Form
  attribute :title, String
  attribute :comment, String
  attribute :rating, Integer
  attribute :book_id, Integer
  attribute :user_id, Integer
  
  validates :title, :rating, :comment, presence: true
  validates :title, length: { maximum: 60 }
  validates :comment, length: { maximum: 400 }
  validates :rating, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 5 }
end  