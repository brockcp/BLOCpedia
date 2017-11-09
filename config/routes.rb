Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  get 'about' => 'welcome#about'
  get 'wikis' => 'wikis#index'
  root 'welcome#index'

end
