Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :currencies, only: [:index, :show]
    end
  end
  post 'authenticate', to: 'authentication#authenticate'
end
