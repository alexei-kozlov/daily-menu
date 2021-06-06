Rails.application.routes.draw do
  root 'daily_menus#index', as: 'home'

  resources :daily_menus, :daily_menu_items, :categories, :menu_items, :pricings, :units
end
