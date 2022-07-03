# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [] do
      collection do
        post :sign_up, action: :create
        post :sign_in
      end
    end

    resources :products, except: [:edit] do
      member do
        post :buy
      end
    end

    resources :carts, only: %i[index] do
      collection do
        post :checkout
      end
    end

    delete :carts, controller: :carts, action: :destroy
  end
end
