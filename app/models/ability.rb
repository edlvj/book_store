class Ability
  include CanCan::Ability

  def initialize(user)
    case user
      when User
        can :read, [Book, Category, Order]
        can :create, Review
        can :update, [Coupon, Book]
        can :manage, [OrderItem, User]
      when AdminUser  
         can :manage, [Author, Book, Category, AdminUser, OrderItem, Order]
      else
        can :read, [Book, Category, Review]
    end     
  end  
end
