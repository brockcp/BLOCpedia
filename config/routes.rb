Rails.application.routes.draw do

  devise_for :users
  resources :wikis
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  resources :charges, only: [:new, :create, :destroy]

  #post 'charges/downgrade'

  get 'about' => 'welcome#about'
  #get 'wikis' => 'wikis#index'
  root 'welcome#index'

end
