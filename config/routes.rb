Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root :to => 'seminars#index'

  get "projects/destroy"

  get "observations/destroy"

  get "participant_activities/destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # ==|== participants and associated resources ==============================
  resources :participants, except: :new do
    get 'enroll', on: :member
    resource :transcript, only: :show
    resources :participant_activities, only: [:update, :destroy], as: :participant_activities, shallow: true
    resources :observations, only: [:update, :destroy], shallow: true
    resources :projects, only: [:update, :destroy], shallow: true
  end


  # ==|== shortcuts to one's own resources ===================================
  # One's own transcript (participant_id will be nil)
  get 'transcript', to: 'transcripts#show'



  patch 'admin/seminars/update_seminar' => 'admin/seminars#update_seminar', :as => 'update_whole_seminar'

  resources :seminars do
    resources :registrations, only: [:create, :destroy]
  end
  get 'registrations', to: 'registrations#index', :as => 'registrations'


  resources :sessions, only: [:create, :destroy]
  get 'login',  to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', via: [:get, :delete]


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
