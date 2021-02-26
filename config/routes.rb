Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tweets#index'

  resources :tweets

  resources :accounts, only:[:show] do
    resources :follows, only:[:create]
    resources :unfollows, only:[:create]
  end

  scope module: :apps do
    resource :profile, only: [:show, :edit, :update]
    resource :timeline, only: [:show]
    resources :favorites, only: [:index]
  end

  namespace :api, defaults: {format: :json} do
    scope '/tweets/:tweet_id' do
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end
end
