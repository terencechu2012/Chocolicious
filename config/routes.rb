Rails.application.routes.draw do
  get 'clubusers/new2'
  post 'clubusers/create2'
  resources :clubusers do
    
  end
  get 'deposits/submitosl'
  get 'deposits/oslprocess'
  get 'users/delete'
  get 'payments/submitosl'
  get 'claims/oslprocess'
  get 'payments/oslprocess'
  post 'admin/editosl'
  get 'admin/manageosl'
  get 'admin/manageoslcbd'
  get 'payments/newpayment'  
  get 'payments/editpayment'
  get 'payments/viewpayment'
  post 'payments/newpayment'  
  post 'payments/editpayment'
  post 'payments/viewpayment'
  get 'payments/addremark'
  post 'payments/addremark'
  post 'payments/confirmrejectpayment'
  get 'payments/confirmrejectpayment'
  post 'payments/edit'
  get 'payments/edit'
  post 'payments/add'
  get 'payments/add'
  post '/payments/clubpayments'
  get '/payments/clubpayments'
  get '/payments/submitpayment'
  post 'payments/editown'
  get '/payments/deletepayment'
  get '/payments/resubmitpayment'
  get 'payments/endorseclub'
  get 'payments/endorsesmusasec'
  get 'payments/endorsecbdmc'
get 'payments/completepayment'
  

  get 'ereceipts/newreceipt'
  get 'ereceipts/viewsentreceipt'

  get 'deposits/addremark'
  get 'deposits/deletedeposit'
  post 'deposits/addremark'
  get 'deposits/clubdeposits'
  get 'deposits/completedeposit'
  get 'claims/completeclaim'
  get 'claims/submitosl'
  get 'chief/setcontributionrate'
  patch 'chief/setrate'
  get 'chief/calculation'
  post 'chief/calculation'
  get 'chief/allocationreports'
  get 'chief/reconcile'
  post 'chief/autoreconcile'
  
  get 'deposits/viewrejecteddeposit'
  get 'deposits/editdeposit'
  get 'deposits/newdeposit' 
  get 'deposits/viewdeposit'  
  post 'deposits/add'  
  post 'deposits/edit'
  post 'deposits/editown'
  get 'deposits/submitdeposit'
  get 'deposits/resubmitdeposit'
  post 'deposits/confirmrejectdeposit'
  get 'deposits/endorseclub'
  get 'deposits/endorsecbdmc'
  get 'deposits/endorsesmusasec'
  devise_for :users, :controllers => {:confirmations => 'confirmations', :registrations => "registrations"}, sign_out_via: :get
  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
    root 'devise/sessions#new'
  end
  resources :users do
    
  end
  
  post 'admin/addclub'
  get 'admin/registerclub'
  post 'admin/add'
  get 'admin/deleteRequest'
  post 'admin/notifications'
  get 'admin/setnric'
  post 'admin/setnric2'
  post 'admin/addLeader'
  get 'admin/selectClub'
  get 'admin/guides'
  post 'admin/requestClub'
  
  post 'admin/deleteclub'

  post 'admin/delete'

  get 'admin/setUserId'
  
  get 'admin/changeclubname'
  patch 'admin/changename'

  get 'chief/changereserveslimit'

  get 'chief/transferfunds'

  get 'chief/modifyuserrole'

  get 'chief/manageclub'

  get 'chief/pullback'

  get 'chief/changeformula'

  get 'chief/allocate'

  get 'chief/injectfunds'

  get 'accounts/viewaccount'
  
  get 'accounts/sacaccount'
  
  post 'accounts/inject'

  get 'accounts/viewcbdaccounts'
  
  post 'accounts/viewcbdaccounts'
  
  get 'accounts/viewcbdaccountsreserve'
  
  post 'accounts/viewcbdaccountsreserve'
  
  get 'accounts/viewsecaccount'
  
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
  
  get 'reserve_limit/viewreservelimit'
  post 'reserve_limit/viewreservelimit'
  post 'reserve_limit/addReserve'
  get 'reserve_limit/viewallreservelimitchangerequest'
  get 'reserve_limit/accept'
  get 'reserve_limit/reject'

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
  
  get 'claims/clubclaims'
  get 'claims/deleteclaim'
  get 'claims/newclaim'
  get 'claims/editclaim'
  get 'claims/viewclaim'
  post 'claims/viewclaim'
  post 'claims/add'
  post 'claims/edit'
  post 'claims/editown'
  get 'claims/submitclaim'
  get 'claims/resubmitclaim'
  get 'claims/addremark'
  post 'claims/addremark'
  get 'claims/endorseclub'
  get 'claims/endorsecbdmc'
  get 'claims/endorsesmusasec'
  post 'claims/confirmrejectclaim'
  get 'claims/viewrejectedclaim'
  
  get 'budgets/control'
  get 'budgets/disallow'
  post 'budgets/allow'
  post 'budgets/allowspending'
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
  
  get 'reserve_withdrawals/newrequest'
  get 'reserve_withdrawals/viewrequest'
  get 'reserve_withdrawals/editrequest'
  post 'reserve_withdrawals/add'
  post 'reserve_withdrawals/edit'
  get 'reserve_withdrawals/addremark'
  post 'reserve_withdrawals/addremark'
  get 'reserve_withdrawals/submitrequest'
  get 'reserve_withdrawals/deleterequest'
  post 'reserve_withdrawals/confirmreject'
  get 'reserve_withdrawals/confirmreject'
  get 'reserve_withdrawals/resubmitrequest'
  get 'reserve_withdrawals/approverequest'
  post 'reserve_withdrawals/approverequest'
  get 'reserve_withdrawals/viewbalance'
  
  get 'funds/newrequest'
  post 'funds/add'
  get 'funds/viewrequest'
  get 'funds/editrequest'
  post 'funds/edit'
  get 'funds/submitrequest'
  get 'funds/deleterequest'
  get 'funds/approverequest'
  get 'funds/addremark'
  post 'funds/addremark'
  post 'funds/confirmreject'
  get 'funds/confirmreject'
  get 'funds/resubmitrequest'
  get 'chief/claimtimes'
  
  get 'ereceipts/newreceipt'
  post 'ereceipts/newreceipt' 
  get 'ereceipts/viewsentreceipt'
  post 'ereceipts/viewsentreceipt'
  get 'ereceipts/add'
  post 'ereceipts/add'
  
  get 'vendors/new'
  post 'vendors/add'
  get 'vendors/edit'
  post 'vendors/edit2'
  get 'vendors/recommend'
  get 'vendors/recommend2'
  get 'vendors/newfromsubmit'
 
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
