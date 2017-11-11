Rails.application.routes.draw do

  devise_for :users

  resources :wikis

  get 'about' => 'welcome#about'
  get 'wikis' => 'wikis#index'
  root 'welcome#index'

end
