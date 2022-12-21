# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'create_offer', to: 'offers#create'
  get 'list_offers', to: 'offers#index'
  get 'get_offer', to: 'offers#show'
  post 'close_offer', to: 'offers#close'
  post 'create_bid', to: 'bids#create'
  delete 'delete_bid', to: 'bids#delete'
end
