Rails.application.routes.draw do
  root 'static_pages#home'

  resources :posts do
    collection do
      get :cities_select
      get :popular
      get :feed
      get :search
    end

    resource :likes, only: %i[create destroy]
  end

  resources :comments, only: %i[create destroy]

  resources :users, only: %i[index show edit update destroy] do
    resource :relationships, only: %i[create destroy]
    member do
      get :like_posts
      get :follows
      get :followers
    end
  end

  devise_for :users,
             path: '',
             path_names: {
               sign_up: '',
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               registrations: 'users/registrations',
               sessions: 'users/sessions',
               passwords: 'users/passwords'
             }
  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end
end
