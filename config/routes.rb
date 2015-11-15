Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :posts do
  	member do
  	  post :vote	
  	end
  end
end
