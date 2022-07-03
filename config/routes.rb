# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [] do
      collection do
        post :sign_up, action: :create
        post :sign_in
      end
    end
  end
end
