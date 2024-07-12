# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # namespace :api, defaults: { format: 'json' } do
  #   resources :users, only: [] do
  #     collection do
  #       post :sign_up, action: :create
  #       post :sign_in
  #     end
  #   end

  #   resources :products, except: [:edit] do
  #     member do
  #       post :buy
  #     end
  #   end

  #   resources :carts, only: %i[index] do
  #     collection do
  #       post :checkout
  #     end
  #   end

  #   # delete :carts, controller: :carts, action: :destroy
  # end

  resource :cart do
    post :checkout
    get :newebpay_callback
  end

  resources :products do
    member do
      post :purchase
    end
  end

  root to: 'home#index'
end
