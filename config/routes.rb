Rails.application.routes.draw do
  root 'menu_items#index', as: 'home'
  get '/categories', to: 'categories#index'

#   get '/menu_items', to: 'menu_items#index'
#   get '/categories/:id', to: 'categories#show', constraints: { id: /\d+/ }
#   patch	'/categories/:id', to:	'categories#update'

#   resources :categories do
#     resources :menu_items
#   end

  resources :menu_items
  resources :categories
end
