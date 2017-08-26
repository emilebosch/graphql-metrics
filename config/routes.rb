GraphqlMetrics::Engine.routes.draw do
  root "dashboard#index"
  resources :queries, only: :show do
  end
end