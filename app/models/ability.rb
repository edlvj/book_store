class Ability
  include CanCan::Ability

  def initialize(user)
    case user
      when User
        can [:read, :update], [Book, Category]
        can [:create], Review
        can :update, Coupon
        can :manage, OrderItem
        can :read, Order
      when AdminUser  
         can :read, [Address, Coupon, CreditCard, User, Shipping]
         can :manage, [Author, Book, Category, AdminUser, OrderItem]
         can :update, Order
      else
        can :read, [Book, Category]
        can :show, Book
        can :read, Review
    end     
  end  
end
