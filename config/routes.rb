# frozen_string_literal: true

Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }

  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }

  root 'administration/items#index'

  get '/home', to: 'home#landing_page'
  
  resources :send_offer, only: [:create]
  namespace 'administration' do
    get '/', to: 'items#index'
    resources :items, only: %i[index update]
  end
end
