class StoreController < ApplicationController
  def index
    @presenter = Books::IndexPresenter.new(params)
  end
end
