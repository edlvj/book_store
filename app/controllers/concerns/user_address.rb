module UserAddress
  extend ActiveSupport::Concern
  
  included do
    def set_addresses user
      [:billing, :shipping].map do |type|
        instance_variable_set("@#{type}_address", Address.find_by(user_id: user.id, addressable_type: "#{type}_address") || Address.new)
        set_names(@billing_address, user)
      end    
    end 
    
    def set_params(params, local_params, use_billing = false)
      [:billing, :shipping].map do |type|
        form_params = params && params[:"#{type}_address"].present? ? params[:"#{type}_address"] : Hash.new
        form_params[:user_id] = local_params[:user_id] if local_params[:user_id]
        form_params[:order_id] = local_params[:order_id] if local_params[:order_id]
        form_params = params["billing_address"] if use_billing
        form_params[:addressable_type] = "#{type}_address"
        instance_variable_set("@#{type}", AddressForm.new(form_params))
      end
    end
    
    def set_names(obj, user_obj)
      obj.firstname = user_obj.firstname if obj.firstname.nil?
      obj.lastname = user_obj.lastname if obj.lastname.nil?
    end    
  end
end  