Rails.application.routes.draw do

  #User
  devise_for :users, :controllers => {registrations: 'users/registrations'}
  resource :sessions, only: [:create, :destroy, :show]
  resource :accounts, only: [:show, :update]

  #Care
  resources :family
  resources :families, only: [:index, :show]
  resources :sitters, only: [:index, :show]

  #Kids
  resources :kids do
    resources :favorites, only: [:create]
  end
  #Kids - can destroy without Kid Id
  resources :favorites, only: [:destroy]

  #Invites: Can be to Sitter or Spouse
  resources :invites do
    member do
      post :accept, to: 'invites#accept', as: :accept
      post :cancel, to: 'invites#cancel', as: :cancel
      post :reject, to: 'invites#reject', as: :reject
    end
  end

end
