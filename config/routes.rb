require File.expand_path("../../lib/authenticated_user", __FILE__)

Rails.application.routes.draw do

  get 'sessions/new'

  get       'activities' => 'activities#index'
  resources :activities
  post      'items/new' => 'items#new'
  resources :items

  post      'houses/:id/edit' => 'houses#edit'
  post      'houses/:id/remove/:user_id' => 'houses#remove', as: :remove_house
  post      'houses/:id/promote/:user_id' => 'houses#promote', as: :promote_house
  resources :houses

  post      'users/:id/edit' => 'users#edit'
  resources :users

	get				'login' => 'sessions#new'
	post			'login' => 'sessions#create'
	delete		'logout' => 'sessions#destroy'
  get       'logout' => 'sessions#destroy'

  post  'events/new' => 'events#new'
  post  'events/export' => 'events#export', as: :export_event
  post  'events/store' => 'events#store', as: :store_event
  post   'events/import' =>  'events#import', as: :import_event
  resources :events

  get      'items/:id/increase' => 'items#increase', as: :increase_item
  get      'items/:id/decrease' => 'items#decrease', as: :decrease_item
  get       'items/:id/movetoshop' => 'items#addtoshop', as: :shop_item
  get       'items/:id/movetoinventory' => 'items#addtoinventory', as: :inv_item


  post  'notes/new' => 'notes#new'
  resources :notes do
    resources :comments
  end

  resources :permissions
  resources :transactions

  post 'polls/new' => 'polls#new'
  resources :polls
  resources :votes, only: [:create]


  # get 'notes/new'

  get 'users/new'

  get 'items/new'

  root :to => 'pages#home'

  #get "inventory" => 'pages#items'
  get "financial" => 'transactions#index'
  #get "notes" => 'pages#notes'
  #get "schedule" => 'pages#schedule'
  get "account" => 'pages#account'
  get "register" => 'pages#signup'

  get 'invitation' => 'invitation#get'
  post 'invitation/create' => 'invitation#create'
  post 'invitation/delete' => 'invitation#delete'
  post 'invitation/email' => 'invitation#email'
  get 'invitation/:token' => 'invitation#view'
  get 'i/:token' => 'invitation#view'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
