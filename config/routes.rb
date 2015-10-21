Rails.application.routes.draw do

  #TODO: change route for signup to be /signup instead of /customers/sign_up
  devise_for :customers, :skip => [:registrations, :sessions]

  as :customer do
    get 'signup' => 'devise/registrations#new', :as => :new_customer_registration
    get 'cancel' => 'devise/registrations#cancel', :as => :cancel_customer_registration
    post '' => 'devise/registrations#create', :as => :customer_registration
    patch '' => 'devise/registrations#update'
    put '' => 'devise/registrations#update'
    delete '' => 'devise/registrations#destroy'
    get 'edit' => 'devise/registrations#edit', :as => :edit_customer_registration


    get 'signin' => 'devise/sessions#new', :as => :new_customer_session
    post 'signin' => 'devise/sessions#create', :as => :customer_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_customer_session
  end

  Rails.application.routes.draw do
    get 'static_pages/welcome'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#welcome'

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
