GraphqlMetrics::Engine.routes.draw do
  root "dashboard#index"
  resources :queries do

  end
end

