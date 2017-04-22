Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords', 
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'user/setting', to: 'users/registrations#edit', as: :setting
    get "sign_in/:type", to: 'users/registrations#new', as: :sign_in
    post "sign_up/:type", to: 'users/registrations#create', as: :sign_up
  end

  resources :store, only: [:index]
  resources :orders, only: [:index, :show, :update, :create]
  resources :checkout, only: [:show, :update]
  resources :books, only: [:index, :show, :update] 
  resources :carts, only: [:index, :create, :destroy] do
    collection do
      match 'update', to: 'carts#update', via: :put, as: :update
    end
  end
  
  root to: 'store#index'
end
