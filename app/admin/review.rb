ActiveAdmin.register Review do
  permit_params :comment, :rating, :user_id, :book_id
  actions :index, :show
  
  index :as => ActiveAdmin::Views::IndexAsTable do
    selectable_column
    column :book do |review|
      review.book.title
    end
    column :user, sortable: :user do |review|
      review.user.firstname
    end
    state_column :state, sortable: :state, states: { approved: "approved" , declined: "rejected"  } do |review|
      review.state
    end
    column :rating, sortable: :rating do |review|
      review.rating
    end
    column :comment, sortable: false do |review|
      truncate(review.comment, length: 100)
    end
    
    column :created, sortable: :created_at do |review|
      review.created_at
    end
    
    actions defaults: true do |review|
      if review.pending?
        item link_to('Approve ', admin_review_path(review, params.permit(:status).merge(status: :approved)), method: :patch)
        item link_to('Reject ', admin_review_path(review, params.permit(:status).merge(status: :declined)), method: :patch)
      end  
    end
  end  

  controller do
    def update
      review = Review.find(params[:id])
      review.approve! if params['status'] == "approved"
      review.decline! if params['status'] == "declined"
      redirect_back(fallback_location: root_path)
    end
  end
end
