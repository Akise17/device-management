Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: redirect('/admin'), as: :root

  namespace :api do
    namespace :v1 do
      get '/device/setting/:device_id/:command', to: 'device#setting', as: :device_setting
      resources :device
    end
  end
end
