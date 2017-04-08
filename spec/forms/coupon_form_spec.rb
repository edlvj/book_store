require 'rails_helper'

RSpec.describe CouponForm, :address_form do
  let(:coupon) { create :coupon }
  
  subject { CouponForm.from_model coupon }
  
  it '#exist_coupon' do
    subject.code = 'java'
    subject.valid?
    expect(subject.errors.full_messages).to include('Code ' +
      I18n.t('valid.coupon.not_found'))
  end
  
  it '#activated_coupon' do
    used_coupon = create :coupon, :used
    coupon_form = CouponForm.from_model used_coupon
    coupon_form.valid?
    expect(coupon_form.errors.full_messages).to include('Code ' +
      I18n.t('valid.coupon.used'))
  end
  
   it '#check_order' do
    order = create :order
    order.coupon = create :coupon, code: 'go'
    subject.valid?(order)
    expect(subject.errors.full_messages).to include('Code ' +
      I18n.t('valid.coupon.check_order'))
  end
  
  
end  