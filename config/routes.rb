require 'sidekiq/web'

Rails.application.routes.draw do
  get 'home' => 'application#home', as: :home
  get 'about' => 'application#about', as: :about
  get 'realtime' => 'application#realtime', as: :realtime
  get 'beverage' => 'application#beverage', as: :beverage
  get 'jsonbev' => 'application#jsonbev', as: :jsonbev
  get 'update' => 'application#update', as: :update
  get 'heatmap' => 'application#heatmap', as: :heatmap
  get 'experiment' => 'application#experiment', as: :experiment
  get 'frameworks' => 'application#frameworks', as: :frameworks
  get 'frameworks_update' => 'application#frameworks_update', as: :frameworks_update
  delete 'clearbev' => 'application#clearbev', as: :clearbev
  root "application#home"

  mount Sidekiq::Web, at: '/sidekiq'

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
