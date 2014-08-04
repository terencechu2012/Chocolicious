Rails.application.routes.draw do
  devise_for :users, :controllers => {:confirmations => 'confirmations', :registrations => "registrations"}
  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
    root 'devise/sessions#new'
  end
  post 'admin/addclub'
  get 'admin/registerclub'
  post 'admin/add'
  get 'admin/deleteRequest'
  post 'admin/notifications'
  get 'admin/setnric'
  post 'admin/setnric2'
  post 'admin/addLeader'

  post 'admin/requestClub'
  
  post 'admin/deleteclub'

  post 'admin/delete'

  get 'admin/setUserId'

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
  
  post 'accounts/viewcbdaccounts'
  
  get 'accounts/viewcbdaccountsreserve'
  
  post 'accounts/viewcbdaccountsreserve'
  
  get 'accounts/forconvenience'
  
  post 'accounts/add'

  get 'accounts/viewallaccounts'

  get 'accounts/deposit'
  
  get 'accounts/editaccount'
  
  get 'accounts/editaccountreserve'
  
  patch 'accounts/updatereserve'

  get 'accounts/fundstransfer'
  
  patch 'accounts/editjustification'
  
  post 'accounts/update'

  get 'claims/newclaim'

  get 'claims/editclaim'

  get 'claims/viewclaim'
  post 'claims/viewclaim'
  

  get 'admin/register'

  get 'admin/login'

  get 'admin/chooserole'
  
  post 'admin/chooserole'

  get 'admin/home'

  get 'admin/newrequest'

  get 'admin/viewrequests'

  post 'admin/loginProcess'

  get 'admin/loginProcess'

  post 'admin/chooseroleProcess'

  get 'admin/logout'

  post 'claims/add'

  post 'claims/edit'

  get 'claims/submitclaim'
  get 'claims/resubmitclaim'
  get 'claims/addremark'
  post 'claims/addremark'
  get 'claims/endorseclub'
  get 'claims/endorsecbdmc'
  get 'claims/endorsesmusasec'
  
  post 'claims/confirmrejectclaim'
  get 'budgets/control'
  get 'budgets/disallow'
  post 'budgets/allow'
  get 'budgets/index'
  get 'budgets/main'
  get 'budgets/reviewmain'
  post 'budgets/additem'
  get 'budgets/delete'
  get 'budgets/managebreakdown'
  get 'budgets/reviewmanagebreakdown'
  post 'budgets/addexpenditure'
  get 'budgets/deleteexpenditure'
  get 'budgets/show'
  get 'budgets/viewbreakdown'
  post 'budgets/addincome'
  get 'budgets/deleteincome'
  get 'budgets/fullsummary'
 
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
