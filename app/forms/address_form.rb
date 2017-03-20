class AddressForm < Rectify::Form
  attribute :firstname,       String
  attribute :lastname,        String
  attribute :address,          String
  attribute :city,             String
  attribute :zipcode,          String
  attribute :phone,            String
  attribute :country,     String
  attribute :addressable_type, String
  attribute :order_id,   Integer
  attribute :user_id,   Integer
  
  validates :firstname,
          :lastname,
          :address,
          :city,
          :zipcode,
          :phone,
          :country,
          :addressable_type,
          presence: true
          
  validates :firstname, :lastname, :city, length: { maximum: 50 }
  validates :zipcode, length: { maximum: 10 }
  validates :phone, length: { minimum: 9, maximum: 15 },
                    format: { with: /\A\+\d{9,15}\z/ }

end