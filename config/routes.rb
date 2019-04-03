Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# custom routes
  scope ':locale', locale: /en|it|fr|ro|ru/ do
    root "welcome#index"
    get 'welcome/index'
    get '/', to: 'welcome#index'
    get '/welcome/about', :as => 'about'
    get '/recipes/database', to: "recipes#database", :as => 'recipes_database'
    post '/recipes/search', to: "recipes#search", :as => 'recipe_search'
    post '/recipes/filter', to: "recipes#filter", :as => 'recipe_filter'


    resources :recipes do
      resources :comments, only: [:new, :create]
    end

    resources :categories, only: [:show]
    resources :users
    resources :sessions,  only: [:new, :create, :destroy]

  end

root "welcome#index"

end
