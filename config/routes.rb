Rails.application.routes.draw do
  get 'experiences/new'
  get 'experiences/index'
  get 'experiences/show'
  get 'experiences/edit'
  get 'experiences/update'
  get 'experiences/destroy'
  root to: 'homes#top'
  get 'homes/top' => 'homes'
  devise_for :users
  get 'user/unsubscribe' => 'users#unsubscribe'
  patch 'user/withdraw' => 'users#withdraw'
  resources :user, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
