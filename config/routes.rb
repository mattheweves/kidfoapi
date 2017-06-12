Rails.application.routes.draw do

  # devise_scope :user do
  #     # write all your routes inside this block
  #     devise_for :users, controllers: { registrations: 'users/registrations' }
  # end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :sessions, only: [:create, :destroy, :show]

  resources :family
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids do
    resources :favorites, only: [:create]
  end
  resources :favorites, only: [:destroy]

  resources :invites do
    member do
      post :accept, to: 'invites#accept', as: :accept
      post :cancel, to: 'invites#cancel', as: :cancel
      post :reject, to: 'invites#reject', as: :reject
    end
  end

end
