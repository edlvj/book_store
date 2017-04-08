class UpdateOrder < Rectify::Command
  attr_reader :order, :params, :coupon_form

  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    if coupon_form.valid?(@order) && update_cart
      type = params[:to_checkout] ? :checkout : :valid
      broadcast type
    else
      broadcast :invalid, coupon_form
    end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:id, :qty])
  end

  def update_cart
    order.coupon = coupon if coupon.present?
    order.update_attributes(order_params)
  end

  def coupon
    @coupon ||= Coupon.find_by_code(params[:coupon][:code]) if params[:coupon]
  end

  def coupon_form
    @coupon_form ||= CouponForm.new params[:coupon]
  end
end