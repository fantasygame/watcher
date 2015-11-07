Rails.application.routes.draw do
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  resources :tvs, only: [:index, :show] do
    resources :seasons, only: [:show]
    resources :episodes, only: [:index]
  end
  resources :episodes do
    collection do
      get :to_see
    end
  end
  resources :views, only: [:create, :destroy] do
    collection do
      get :set_all
      get :unset_all
    end
  end
  resources :subscriptions, only: [:create, :destroy, :index]
end
