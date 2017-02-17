Rails.application.routes.draw do
  resources :categories

  resources :tags
  post 'collections/show' => 'collections#build'
  get 'collections/giftbuilder' => 'collections#gift_builder'
  get "/pages/:page" => "pages#show"

  resources :likes

  resources :collections do
    get :least_to_most
    get :most_to_least
    get :recent
    get :hot
    get :prime
  end

  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations',omniauth_callbacks: "users/omniauth_callbacks"  }
  resources :users, :only => [:show]
  
  get 'products/categories'
  get 'products/recent' => 'products#recent'
  get 'products/hot' => 'products#hot'
  get 'products/most_to_least' => 'products#most_to_least'
  get 'products/least_to_most' => 'products#least_to_most'
  get 'products/prime' => 'products#prime'

  post 'products/populate' => 'products#get_amazon'
  post 'products/like' => 'products#like_product'

  resources :products

  root 'products#index'

end
