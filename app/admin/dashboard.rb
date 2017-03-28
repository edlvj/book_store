ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
     column do
        panel "Recent Reviews" do
          ul do
            Review.last(5).map do |review|
              li link_to(review.id,  admin_review_path(review))
           end
       end
     end
   end

  end
  end
end