Rails.application.routes.draw do
  resources :watch_brands
  resources :rolex_models
  resources :rolex_model_watches
  resources :brand_watches
  post '/brand_watches/', to: 'brand_watch#showmodels'
end
