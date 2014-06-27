require "sidekiq/web"
Rails.application.routes.draw do
  # Sidekiq web interface
  constraint = lambda { |request| request.env["warden"].authenticate? }
  constraints constraint do
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :articles do
    put :read,  on: :member
    put :click, on: :member
    get :star,  on: :member
    get :starred, on: :collection
  end

  resources :feeds do
    get :fetch_articles, on: :collection
    get :working, on: :collection
    get :feed_working, on: :member
    get :unread, on: :member
    put :read_all, on: :member
  end

  resources :categories do
    get  :sort, on: :collection
    post :sort_update, on: :collection
    get  :read_all, on: :member
  end

  devise_for :users

  get "starred",  to: "pages#starred"
  get "settings", to: "pages#settings"
  get "readall",  to: "pages#read_all"
  root "pages#index"
end
