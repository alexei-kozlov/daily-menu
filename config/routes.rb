Rails.application.routes.draw do
  root 'categories#index', as: 'home'

  resources :categories, :menu_items, :pricings
end
