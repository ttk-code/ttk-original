Rails.application.routes.draw do
  root "toppages#index"

	get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

	get 'signup', to: 'users#new'
	resources :users, only: [:index,:show, :new, :create, :edit, :update, :destroy] do
	  member do
      get :followings
      get :followers

      get :likes
    end
	end

	resources :posts, only: [:show, :new, :edit, :create, :update, :destroy] do
	  resources :comments, only: [:create, :destroy]
	end

  resources :relationships, only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]


end