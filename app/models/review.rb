class Review < ApplicationRecord
  include AASM
  belongs_to :book
  belongs_to :user
  
  aasm column: :state do
    state :pending, :initial => true
    state :approved
    state :declined
    
    event :approve do
      transitions :to => :approved, :from => [:pending]
    end
    
    event :decline do
      transitions :to => :declined, :from => [:pending]
    end
  end
  
end
