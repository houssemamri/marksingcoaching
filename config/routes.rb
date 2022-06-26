Rails.application.routes.draw do
  default_url_options host: '123leadmagnets.com'

  root 'static_pages#home'
  get '/about', to: 'sales_pages#about'

  # Payments
  resources :payments
  get '/thank-you', to: 'payments#thank_you'
  get '/sign-up-offer', to: 'sales_pages#sign_up_offer'

  # Content
  resources :podcasts
  resources :articles
  resources :contents
  resources :courses do
    resources :course_modules, path: :modules
  end
  resources :course_modules

  # REFERRAL PROGRAM
  # resources :referred_users
  get 'unlock' => 'referred_users#new'
  resources :referred_users, only: [:create]
  # post 'referred_users/create' => 'referred_users#create'
  get 'refer-a-friend' => 'referred_users#refer'
  get '/referrer/:id' => 'referred_users#confirm_and_set_referrer_cookie'

  # Legal
  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'
  get '/content-licensing', to: 'static_pages#content_licensing'

  # Error Pages
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unacceptable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Patterns
  get '/patterns' => 'static_pages#patterns'

  resources :cart_items, only: %i[create destroy]

  # SITE MAP
  get '/sitemap.xml' => 'sitemaps#index', defaults: { format: 'xml' }
  # ROBOTS
  get '/robots.:format', to: 'robots#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations' }
  ActiveAdmin.routes(self)

  # Home
  get '/dashboard', to: 'home#index'
end
