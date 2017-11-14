Rails.application.routes.draw do

  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]

  post 'charges/downgrade'

  get 'about' => 'welcome#about'
  get 'wikis' => 'wikis#index'
  root 'welcome#index'

end
