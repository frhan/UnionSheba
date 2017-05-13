Rails.application.routes.draw do

  get 'home/index'

  resources :citizens do
    member do
      get :edit_request
      get :activate_citizen
      put :permit_request
    end
    collection do
      get :requests
      get :verify_application
      get :verify_citizen
    end
  end

  get 'citizens/show_by_tracking_id/:id' => 'citizens#show_by_tracking_id', as: :show_by_tracking_citizens

  resources :citizen_requests do
    collection do
      get :search
    end
  end

  resources :forms do
    collection do
      get :tax_or_rate_form
      get :others_form
    end
  end
  resources :collection_moneys
  resources :tax_or_rate_collections do
      collection do
        get :report
      end
  end
  resources :others_collections
  resources :trade_licenses
  resources :profiles
  resources :trade_organizations,shallow: true do
    member do
      get :renew
      post :create_trade_license
      get :print_money_recipt
    end
  end

  #get 'citizen_requests/show_by_birthid/:id' => 'citizen_requests#show_by_birthid', as: :show_by_birthid_citizen_request
  #get 'citizen_requests/show_by_nid/:id' => 'citizen_requests#show_by_nid', as: :show_by_nid_citizen_request

  get 'trade_organizations/:id/trade_license/:license_id/edit' => 'trade_organizations#edit_license',
      as: :edit_trade_org_trade_license

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  namespace :api do
    resources :divisions do
      member do
        get :districts
      end
    end

    resources :districts do
      member do
        get :upazilas
      end
    end

    resources :upazilas do
      member do
        get :unions
      end
    end

    resources :unions

  end

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
