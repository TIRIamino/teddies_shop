Rails.application.routes.draw do
  devise_for :users
  root 'teddies#index'
  resources :teddies, only: [:index, :show]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end


  StripeEvent.signing_secret = Rails.configuration.stripe[:signing_secret]

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
