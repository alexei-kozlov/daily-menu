Rails.application.routes.draw do
  root 'daily_menus#index', as: 'home'
#   get 'categories' => 'categories#index'
#   get 'menu_items' => 'menu_items#index'

#   get '/categories/:id', to: 'categories#show', constraints: { id: /\d+/ }
#   patch	'/categories/:id', to:	'categories#update'

#   resources :categories, shallow: true do
#     resources :menu_items
#   end

  resources :daily_menus, :daily_menu_items, :categories, :menu_items
end
