Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games do
    collection do
      get 'search'
      get 'all'
    end
    resources :comments, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
