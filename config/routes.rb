Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'items/search#show'
      get '/items/find_all', to: 'items/search#index'
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'

      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      namespace :items do
        # resources :merchant, only: [:show]
        get '/:id/merchant', to: 'merchant#show'
        # get '/find', to: "search#show"
      end

      namespace :merchants do
        # resources :items, only: [:index]
        get '/:id/items', to: 'items#index'
      end


    end
  end
end
