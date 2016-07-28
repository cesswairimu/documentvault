Rails.application.routes.draw do


  root  'docpages#home'

  get'about' => 'docpages#about'

  get 'support' => 'docpages#support'
  get 'join' => 'users#new'
  get 'login' => 'logins#new'
  post 'login' => 'logins#create'
  resources :users
  resources :logins
end
