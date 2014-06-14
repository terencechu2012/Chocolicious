Rails.application.routes.draw do
  get 'chief/changereserveslimit'

  get 'chief/transferfunds'

  get 'chief/modifyuserrole'

  get 'chief/manageclub'

  get 'chief/pullback'

  get 'chief/changeformula'

  get 'chief/allocate'

  get 'chief/injectfunds'

  get 'accounts/viewaccount'

  get 'accounts/viewcbdaccounts'

  get 'accounts/viewallaccounts'

  get 'accounts/deposit'

  get 'accounts/fundstransfer'

  get 'claims/newclaim'

  get 'claims/editclaim'

  get 'claims/viewclaim'

  get 'admin/register'

  get 'admin/login'

  get 'admin/chooserole'

  get 'admin/home'

  get 'admin/newrequest'

  get 'admin/viewrequests'
  
  post 'admin/loginProcess'
  
  post 'admin/chooseroleProcess'
  
  get 'admin/logout'
  
  post 'claims/add'
  
  post 'claims/edit'
  
  get 'claims/submitclaim'

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
