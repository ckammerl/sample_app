# This arranges both for a valid page at /help (responding to GET requests) and a named route called help_path that 
# returns the path to that page. (Actually, using 'get' in place of 'match' gives the same named routes, but using match 
# is more conventional.)

# the code match ’/about’ automatically creates named routes for use in the controllers and views: 
    # about_path -> /about
    # about_url -> http://localhost:3000/about

# You can have the root of your site routed with "root"
  # root 'welcome#index' or in this case root 'static_pages#home' and we also automatically get the URL helpers (named routes):
      #root_path -> '/'
      #root_url  -> 'http://localhost:3000/'


SampleApp::Application.routes.draw do
  get "users/new"

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get' # As with the other routes, match ’/signup’ gives us the named route signup_path
  match '/help',    to: 'static_pages#help',    via: 'get' 
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'



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
