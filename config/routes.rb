Rails.application.routes.draw do

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: "home#index"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get '/fixtures' => 'home#fixtures'
  get '/table' => 'home#table', as: :table
  get '/results' => 'home#results', as: :results

  get  '/home' => 'home#new'
  get  '/home/:id/bet' => 'home#bet', as: :bet
  post 'home/bet/:id/create' => 'home#createbet', as: :createbet
  get  '' => 'home#index'
  get '/delete/comment' => 'home#delete_comment', as: :delete_comment
  get '/bet/:id/comments' => 'home#comments', as: :comments
  get '/bet/results' => 'home#bet_results', as: :bet_results
  get '/leagues' => 'leagues#index', as: :leagues


  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):

    resources :users
    resources :admins
    get  '/remove_bets' => 'admins#remove_bets', as: :remove_bets
    resources :bet_matches
    # resources :comments

    get '/bet/:id/comments' => 'home#show_comments', as: :bet_comments
    post '/bet/create_comment/:id/:page_number' => 'home#create_comment', as: :create_comment
    post 'bet/vote' => 'home#vote', as: :vote
    get '/show/predicted_coins' => 'home#coins_predicted', as: :predicted_coins
    get '/bet_history' => 'home#bet_history', as: :bet_history

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
