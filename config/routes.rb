Rails.application.routes.draw do
  root 'menu_items#index', as: 'home'

  resources :menu_items
end
