Legitracker::Application.routes.draw do
  devise_for :users

  get "statuses/index"

  get "votes/show"

  resources :bills do
    resources :votes
    resources :statuses
    resources :sponsorships
  end
  
  resources :members do
    resources :sponsorships
  end
  
  resources :votes do
    resources :bills
  end

  get "members/index"
  get "members/show"
  get "home/index"
  get "bills/index"
  get "bills/show"
  get 'bills/search'
  root :to => "home#index"

  match 'search' => 'bills#search'
  match 'statuses' => 'statuses#index'
  match 'hot/:id' => 'bills#hot', :as => 'hot_bill'
  match 'unhot/:id' => 'bills#unhot', :as => 'unhot_bill'
  match 'key/:id' => 'votes#key', :as => 'key_vote'
  match 'unkey/:id' => 'votes#unkey', :as => 'unkey_vote'
  match 'add_tag/:id' => 'bills#add_tag', :as => 'tag'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
