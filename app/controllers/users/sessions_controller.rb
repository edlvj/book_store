class Users::SessionsController < Devise::SessionsController

   def new
     super { return render 'users/sessions/checkout_login' if params[:type] == "checkout" }
   end

   def create
     super do
       if params[:type] == "checkout"
         raise params.inspect
         resource.skip_password_validation = true
         resource.save
       end
     end
   end

end
