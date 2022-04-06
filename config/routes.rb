Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'AdminUser', at: 'admin_users', controllers: {
        sessions: 'api/v1/admin_users/sessions'
      }

      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations:  'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
    end
    namespace :v1, defaults: { format: :json } do
      resources :topics, only: [:index]
    end
    end
end
