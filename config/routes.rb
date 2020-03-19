Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        scope module: :merchant do
          resources :items, only: [:index]
        end
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        scope module: :item do
          resource :merchant, only: [:show]
        end
      end
    end
  end
end
