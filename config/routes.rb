Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root "welcome#index"

  get '/welcome/about', :as => 'about'

  # post '/hunts/search', :as => 'hunt_search'

  resources :recipes do
    resources :comments
  end

  resources :categories
  resources :users
  resources :sessions

end
