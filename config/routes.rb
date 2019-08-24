Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'
  post "widget_customization/update", to: "widget_customization#update"
  root to: 'home#index'
end
