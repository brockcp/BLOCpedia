Rails.application.routes.draw do

  devise_for :users
  get 'welcome/about'
  get 'welcome/about'
  root 'welcome#index'

end
