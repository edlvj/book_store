class BooksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @presenter = Books::MainPresenter.new(params)
  end
  
  def show
    @review_form = ReviewForm.new
  end
  
  def update
    CreateReview.call(user: current_user, book: @book, params: params) do
      on(:valid) do |book|
        redirect_to @book, notice: t('flash.success.created_review')
      end
      on(:invalid) do |review_form|
        flash_render :show, alert: t('flash.failure.created_review')
      end
    end
  end 
  
end
