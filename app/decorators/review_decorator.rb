class ReviewDecorator < Drape::Decorator
  delegate_all
  decorates_association :user
  
  def image
    object.user.image? ? object.user.image : "/uploads/noUserPic.png"
  end 
  
  def created_date
    created_at.strftime("%Y/%m/%d")
  end 
  
  def username
    "#{object.user.firstname} #{object.user.lastname}"
  end  
  
  def verified
    "Verified Reviewer"
  end  
  
end