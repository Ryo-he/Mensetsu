Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'homes#top'
  get 'homes/top' => 'homes#top'
  get 'users/unsubscribe' => 'users#unsubscribe'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :experiences do
    resource :favorites, only: [:create, :destroy]
  end
  get 'search' => 'experiences#search'
  resources :genres, only: [:index, :edit, :update, :destroy, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
