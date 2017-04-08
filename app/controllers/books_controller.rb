class BooksController < ApplicationController
  include Rectify::ControllerHelpers
  load_and_authorize_resource only: [:update, :show]
  before_action :set_review_form,  only: [:update, :show]
  
  def index
    @presenter = Books::CatalogPresenter.new(params)
  end
  
  def update
    CreateReview.call(user: current_user, book: @book, params: params) do
      on(:valid) do |book|
        flash[:notice] = t('flash.success.created_review')
        redirect_to book
      end
      on(:invalid) do |review_form|
        expose review_form: review_form
        flash[:alert] = t('flash.failure.created_review')
        render :show
      end
    end
  end 
  
  private
  
  def set_review_form
    @review_form = Review.new
  end  
end
