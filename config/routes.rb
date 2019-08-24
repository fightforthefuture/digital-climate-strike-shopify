Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'

  post "shop/update", to: "shop#update"
  get "shop", to: "shop#show"

  root to: 'home#index'
end
