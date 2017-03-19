class CreditCardForm < Rectify::Form
  attribute :name, String
  attribute :number, String
  attribute :cvv, Integer
  attribute :expiration_date, String
  attribute :user_id, Integer
  attribute :order_id, Integer
  
  validates_presence_of :number, :cvv, :name, :expiration_date
 
  validates :number, format: { with: /\A[0-9]\d+/ }, length: { maximum: 16 }
  validates :cvv, length: { in: 3..4 }
  validates :name, length: { maximum: 50 },
                    format: { with: /[A-z]/i }
  validates :expiration_date, length: { maximum: 5 }
end