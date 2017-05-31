Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids do
    resources :favorites, only: [:create]
  end
  resources :favorites, only: [:destroy]
end
