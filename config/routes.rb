GraduateStudents::Application.routes.draw do
  get "observations/destroy"

  get "participant_activities/destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # ==|== participants and associated resources ==============================
  resources :participants, except: :new do
    get 'enroll', on: :member
    resource :transcript, only: :show
    resources 'participant-activities', only: :destroy, as: :participant_activities, shallow: true
    resources :observations, only: :destroy, shallow: true
  end


  # ==|== shortcuts to one's own resources ===================================
  # One's own transcript (participant_id will be nil)
  get 'transcript', to: 'transcripts#show'



  put 'admin/seminars/update_seminar' => 'admin/seminars#update_seminar', :as => 'update_whole_seminar'

  resources :seminars do
    resources :registrations, only: [:create, :destroy]
  end
  get 'registrations', to: 'registrations#index', :as => 'registrations'


  resources :sessions, only: [:create, :destroy]
  match 'login',  to: 'sessions#create'
  match 'logout', to: 'sessions#destroy', via: [:get, :delete]
 

  get 'search' => 'search#show', :as => 'search'

  get 'admin' => 'admin/seminars#index', :as => 'root_admin_url'
   namespace :admin do
    # Directs /admin/seminars/* to Admin::SeminarController
    # (app/controllers/admin/seminars_controller.rb)
    resources :seminars do
      resources :registrations
    end

    resources :spreadsheets, only: [:show]
    resources :settings, only: [:index, :update]
  end

  #resources :registrations
  

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
  #root :to => 'admin/seminars#index'
  #root :to => 'registrations#new'
  #root :to => 'welcome#index'
  root :to => 'seminars#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
