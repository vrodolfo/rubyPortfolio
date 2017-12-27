Rails.application.routes.draw do

  get 'projects/new'

  get    ''                                   => 'sessions#index'
  get    ':pageProjects&:pageSkills&:pageEdu' => 'sessions#index'       , as: 'root'
  get    'sessions/new'                    => 'sessions#new'         , as:'sessionsNew'
  post   'sessions'                        => 'sessions#create'      , as:'sessionsCreate'
  post   'sessions/send'                   => 'sessions#email'       , as:'sessionsSend'
  delete 'sessions'                        => 'sessions#destroy'     , as:'sessionsDestroy'

  get    'users/new'                       => 'users#new'             , as:'usersNew'
  post   'users'                           => 'users#create'          , as:'usersCreate'
  get    'users/:user_id'                  => 'users#show'            , as:'usersShow'
  patch  'users/:user_id'                  => 'users#update'          , as:'usersUpdate'
  delete 'users/:user_id'                  => 'users#destroy'         , as:'usersDestroy'
  get    'users/:user_id/edit'             => 'users#edit'            , as:'usersEdit'
  
  get    'main/:user_id'                   => 'users#index'           , as:'main'

  get    'skills/cancel'                   => 'skills#cancel'         , as:'skillsCancel'
  get    'skills/new'                      => 'skills#new'            , as:'skillsNew'
  get    'skills'                          => 'skills#index'          , as:'skillsIndex'
  post   'skills'                          => 'skills#create'         , as:'skillsCreate'
  get    'skills/:skill_id'                => 'skills#show'           , as:'skillsShow'
  patch  'skills/:skill_id'                => 'skills#update'         , as:'skillsUpdate'
  delete 'skills/:skill_id'                => 'skills#destroy'        , as:'skillsDestroy'
  get    'skills/:skill_id/edit'           => 'skills#edit'           , as:'skillsEdit'


  get    'courses/cancel'                  => 'courses#cancel'         , as:'coursesCancel'
  get    'courses/new'                     => 'courses#new'           , as:'coursesNew'
  get    'courses'                         => 'courses#index'         , as:'coursesIndex'
  post   'courses'                         => 'courses#create'        , as:'coursesCreate'
  get    'courses/:education_id'              => 'courses#show'          , as:'coursesShow'
  patch  'courses/:education_id'              => 'courses#update'        , as:'coursesUpdate'
  delete 'courses/:education_id'              => 'courses#destroy'       , as:'coursesDestroy'
  get    'courses/:education_id/edit'         => 'courses#edit'          , as:'coursesEdit'

  get    'projects/cancel'              => 'projects#cancel'         , as:'projectsCancel'
  get    'projects/new'                 => 'projects#new'       , as:'projectsNew'
  get    'projects'                     => 'projects#index'     , as:'projectsIndex'
  post   'projects'                     => 'projects#create'    , as:'projectsCreate'
  get    'projects/:project_id'         => 'projects#show'      , as:'projectsShow'
  patch  'projects/:project_id'         => 'projects#update'    , as:'projectsUpdate'
  delete 'projects/:project_id'         => 'projects#destroy'   , as:'projectsDestroy'
  get    'projects/:project_id/edit'    => 'projects#edit'      , as:'projectsEdit'

  get    'experiences/new'                 => 'experiences#new'       , as:'experiencesNew'
  get    'experiences'                     => 'experiences#index'     , as:'experiencesIndex'
  post   'experiences'                     => 'experiences#create'    , as:'experiencesCreate'
  get    'experiences/:experience_id'      => 'experiences#show'      , as:'experiencesShow'
  patch  'experiences/:experience_id'      => 'experiences#update'    , as:'experiencesUpdate'
  delete 'experiences/:experience_id'      => 'experiences#destroy'   , as:'experiencesDestroy'
  get    'experiences/:experience_id/edit' => 'experiences#edit'      , as:'experiencesEdit'



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
