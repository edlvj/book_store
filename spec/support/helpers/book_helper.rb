module Support
  module Book
    def fill_review(form_id, options)
      within "##{form_id}" do
        fill_in 'review[title]', with: options[:title]
        fill_in 'review[comment]', with: options[:comment]
        #choose("rate_#{options[:grade]}", visible: false)
        click_button I18n.t('book.post')
      end
    end
  end
end