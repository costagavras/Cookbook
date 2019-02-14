Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#4 custom routes
  get 'welcome/index'
  root "welcome#index"
  get '/welcome/about', :as => 'about'
  post '/recipes/search', :as => 'recipe_search'

  resources :recipes do
    resources :comments, only: [:new, :create]
  end

  resources :categories, only: [:show]
  resources :users
  resources :sessions,  only: [:new, :create, :destroy]

end
