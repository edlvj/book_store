class CreditCardForm < Rectify::Form
  attribute :name, String
  attribute :number, String
  attribute :cvv, Integer
  attribute :expiration_date, String
  attribute :user_id, Integer
  
  validates_presence_of :number, :cvv, :name, :expiration_date
 
  validates :number, format: { with: /\A[0-9]\d+/ }, length: { is: 16 }
  validates :cvv, length: { in: 3..4 }
  validates :name, length: { maximum: 50 },
                    format: { with: /[a-zA-zа-яA-Я]/ }
  validates :expiration_date, format: { with: /(0[1-9]|1[0-2])\/[0-9]{2}/, message: "Format must be mm/yy" }, length: { maximum: 5 }
end