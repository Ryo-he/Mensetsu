Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/top' => 'homes'
  devise_for :users
  get 'user/unsubscribe' => 'users#unsubscribe'
  patch 'user/withdraw' => 'users#withdraw'
  resources :user, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
