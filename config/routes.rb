Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"

  resources :recipes do
    resources :comments
  end

  resources :categories
  resources :users
  resources :sessions

end
