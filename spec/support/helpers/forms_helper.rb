module Support
  module Forms
    def fill_review_form(form_id, options)
      within "##{form_id}" do
        fill_in 'review[title]', with: options[:title]
        fill_in 'review[comment]', with: options[:comment]
        find('#review_rate', visible: false).set(options[:rating])
        find('.btn', I18n.t('book.post')).click
      end
    end
    
    def fill_coupon_form(form_id, code)
      within "##{form_id}" do
        first('#coupon_code').set(code)
        first('#update_coupon', I18n.t('cart.update_cart')).click
      end
    end
    
    def fill_cart_form(form_id, book_id, count)
      within "##{form_id}" do
        first("#qty_#{ book_id }").set(count)
        first("#update_coupon", I18n.t('cart.update_cart')).click
      end
    end
    
    def fill_address_form(type, options, use_billing = false)
      within "##{type}" do
        fill_in "order[#{type}][firstname]", with: options[:firstname]
        fill_in "order[#{type}][lastname]", with: options[:lastname]
        fill_in "order[#{type}][address]", with: options[:address]
        fill_in "order[#{type}][city]", with: options[:city]
        fill_in "order[#{type}][zipcode]", with: options[:zipcode]
        fill_in "order[#{type}][phone]", with: options[:phone]
        find("#order_#{type}_country_id").find(:xpath, 'option[1]').select_option
      end
        find("#use_billing", visible: false).set(true) if use_billing
        click_button I18n.t('checkout.save_and_continue')
    end
    
    def fill_payment_form(form_id, options)
      within "##{form_id}" do
        fill_in 'order[credit_card_attributes][number]', with: options[:number]
        fill_in 'order[credit_card_attributes][name]', with: options[:name]
        fill_in 'order[credit_card_attributes][expiration_date]', with: options[:expiration_date]
        fill_in 'order[credit_card_attributes][cvv]', with: options[:cvv]
        first('.btn', I18n.t('checkout.save_and_continue')).click
      end  
    end  
 
  end
end