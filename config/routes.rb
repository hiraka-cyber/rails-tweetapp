Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :articles do
    resources :comments
    resources :likes
  end
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
