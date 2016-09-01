Rails.application.routes.draw do
  devise_for :users
  root to: "visitors#index"
  resources :tvs, only: [:index, :show] do
    resources :seasons, only: [:show]
    resources :episodes, only: [:index]
  end
  resources :episodes do
    collection do
      get :to_see
    end
  end
  resources :views, only: [] do
    collection do
      get :set_all
      get :unset_all
    end
    member do
      get :toggle
    end
  end
  resources :subscriptions, only: [:create, :destroy, :index] do
    collection do
      get :seen
    end
  end
end
