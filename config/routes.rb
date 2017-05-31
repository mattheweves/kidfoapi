Rails.application.routes.draw do

  devise_scope :user do
      # write all your routes inside this block
      devise_for :users, controllers: { registrations: 'users/registrations' }
  end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids do
    resources :favorites, only: [:create]
  end
  resources :favorites, only: [:destroy]
end
