class CartsController < ApplicationController
  include ApplicationHelper
  
  def index
    @coupon_form = CouponForm.new
  end
  
  def create
    AddToCart.call(current_order, params) do
      on(:valid) do |quantity|
        flash[:notice] = t('flash.success.book_add', count: quantity)
      end
      on(:invalid) do |errors|
        flash[:alert] = t('flash.failure.book_add', errors: errors)
      end
    end
    redirect_back(fallback_location: root_path)
  end  
 
  def update
    UpdateOrder.call(current_order, params) do
      on(:valid) { redirect_to carts_path,
                   notice: t('flash.success.cart_update') }
      on(:checkout) { redirect_to checkout_path(:address) }
      on(:invalid) do |errors|
        flash[:alert] = t('flash.failure.cart_update', error: parse_error(errors, :code))
        render :index
      end
    end
  end
  
  def destroy
    order_item = OrderItem.find(params[:id])
    if order_item.destroy && current_order.save
      flash[:notice] = t('flash.success.book_destroy', 
                        title: order_item.book.title)
    else
      flash[:alert] = t('flash.failure.book_destroy',
                        errors: order_item.decorate.all_errors)
    end
    redirect_back(fallback_location: carts_path)
  end  
end