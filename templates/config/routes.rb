Rails.application.routes.draw do
  # Design System (development only)
  if Rails.env.development?
    namespace :design_system, path: "design_system" do
      root to: "pages#home"

      get "colors", to: "pages#colors"
      get "typography", to: "pages#typography"

      resources :components, only: [ :index, :show ], param: :name
    end
  end

  devise_for :users

  # Authenticated root (dashboard)
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  # Unauthenticated root redirects to sign in
  devise_scope :user do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
