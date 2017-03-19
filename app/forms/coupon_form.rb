class CouponForm < Rectify::Form
  attribute :code, String

  validate :exist
  validate :activated

  def valid?(order = nil)
    super
    check_order(order) if order.present?
    errors.empty?
  end

  private

  def exist
    return if code.blank? || !current_coupon.nil?
    errors.add(:code, I18n.t('valid.coupon.not_found'))
  end

  def activated
    return if code.blank? || current_coupon.blank? ||current_coupon.active?
    errors.add(:code, I18n.t('valid.coupon.used'))
  end

  def check_order(order)
    return if code.blank? || order.coupon.blank?
    errors.add(:code, I18n.t('valid.coupon.check_order'))
  end

  def current_coupon
    Coupon.find_by(code: code)
  end
end