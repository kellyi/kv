Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :store, only: [:index, :create, :show] do
      collection do
        put '/', action: 'update'
        delete '/', action: 'destroy'
      end
    end
  end
end
