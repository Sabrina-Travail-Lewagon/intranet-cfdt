Rails.application.routes.draw do
  get 'uploader/image'
  get 'articles/index'
  get 'articles/show'
  get 'articles/edit'
  get 'articles/destroy'
  devise_for :users
  # devise_for :users, controllers: { registrations: 'registrations'}
  root to: "pages#home"
  resources :articles
  resources :categories do
    member do
      get 'articles', to: 'categories#category_articles'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
