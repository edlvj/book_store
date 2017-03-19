Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords', 
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'user/setting', to: 'users/registrations#edit', as: :setting
    get "sign_in/:type", to: 'users/sessions#new', as: :sign_up
    post "sign_up/:type", to: 'users/sessions#create'
  end

  resources :store, only: [:index, :show]
  resources :carts, only: [:index, :update, :create, :destroy]
  resources :orders, only: [:index, :show, :update, :create]
  resources :checkout, only: [:show, :update]
  resources :books, only: [:index, :show, :update] 
  
  root to: 'store#index'
end
