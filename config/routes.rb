Rails.application.routes.draw do
  devise_for :users
  get "snippets/show"

  get "/support/cookie", :controller => "support", :action => "cookie"

  get "/samples", :controller => "samples", :action => "index"
  get "/samples/:page" => "samples#show"
  post "/samples/:page" => "samples#show"
 
  namespace :admin do
    resources :examples, :products, :versions, :categories, :snippets, :attachments, :users
    get "/help/(:type)", :controller => "help", :action => "index", :as => "help"
    get "feedback/list", :controller => "feedback", :action => "list"
    get "feedback/list/:id", :controller => "feedback", :action => "view", :as => "example_feedback"
    delete "feedback/:id", :controller => "feedback", :action => "destroy", :as => "feedback_delete"
  end
  
  get "/js/:action(.:format)", :controller => "js"
  
  post "/feedback/(:id)", :controller => "feedbacks", :action => "create", :as => "feedbacks"

  get "/search/(:q)", :controller => "examples", :action => "search", :as => "examples_search"

  get "/examples(.:format)", :controller => "examples", :action => "index", :as => "examples_index"
  get "/legacy(.:format)", :controller => "examples", :action => "legacy", :as => "examples_legacy_index"

  get "/snippets/:id", controller: 'snippets', action: 'show'

  get "/:id(.:language)", :constraints => {:id => /[0-9]+/}, :controller => 'examples', :action => 'show_id', :as => 'example_id'
  get "/Toolkit_Professional(/:version(/:title(.:language)))", to: redirect { |path_params, req| "/Toolkit/#{path_params[:version]}/#{path_params[:title]}.#{path_params[:language]}" }
  get "/:product/:version/download.:language", :controller => "examples", :action => "download_all_examples", :as => "examples_download"
  get "/:product(/:version(/:title(.:language)))", :controller => "examples", :action => "show", :as => "examples"
  get "/:product/:version/:title.:language/documentation", :controller => "examples", :action => "documentation", :as => "example_documentation"
  get "/:product/:version/:title.:language/download", :controller => "examples", :action => "download", :as => "example_download"
  get "/:product/:version/:title.:language/download_all", :controller => "examples", :action => "download_all", :as => "example_download_all"
  get "/:product/:version/:title.:language/download_package", :controller => "examples", :action => "download_package", :as => "example_download_package"

  post "/contact_mailer", :controller => "contact", :action => "create"

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
  root :to => "examples#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
