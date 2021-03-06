require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tweets#index'

  get 'news/data'
  get 'news/index'

  resources :tweets do
    collection do
      get 'search'
    end
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :users, only: [:index, :destroy]

  resources :notifications, only: [:index]

  resources :complaints, only: [:index, :create, :destroy]

  resources :accounts, only:[:show] do
    resources :follows, only:[:index, :show, :create]
    resources :followings, only: [:index]
    resources :unfollows, only:[:create]
  end

  scope module: :apps do
    resource :profile, only: [:show, :edit, :update]
    resource :timeline, only: [:show]
    resource :popular_post, only: [:show]
    resources :favorites, only: [:index]
  end

  namespace :api, defaults: {format: :json} do
    scope '/tweets/:tweet_id' do
      resource :like, only: [:show, :create, :destroy]
    end
  end
end
