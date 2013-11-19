Lesxviezvous::Application.routes.draw do

  root to: 'posts#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :posts do
    get 'vote'
    get 'validate'
    get 'favorite'
    get 'reblog'
  end

  resources :categories do
    resource :posts
  end

  resources :communities do 
    get :join
    get :leave
    get :ban
    get :mute
  end

  resources :users do 
    get 'follow'
  end

  resources :questions do
    get :vote
    get :print_answers
  end

  resources :answers do
    get 'vote'
    get 'valid'
  end

  get 'moderation', to: 'posts#moderate'
  get 'fakes', to: 'posts#index_fakes'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  match 'search', to: 'search#index', via: [:get, :post]
  match 'autocomplete', to: 'search#autocomplete', via: [:get, :post]

  resources :users
  resources :sessions


  #Timeline
  match "/load_more" => "posts#load"
  match "/timeline/get" => "timeline#show"

  # Authentication routes

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: Thi
end