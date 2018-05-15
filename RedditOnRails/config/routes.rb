Rails.application.routes.draw do

  resources :subs, except: [:destroy]
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  root :to => 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
