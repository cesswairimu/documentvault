Rails.application.routes.draw do



  root  'docpages#home'

  get'about' => 'docpages#about'

  get 'support' => 'docpages#support'
  get 'mail' => 'docpages#mail'
  get 'join' => 'users#new'
  get 'login' => 'logins#new'
  post 'login' => 'logins#create'
  delete 'logout' => 'logins#destroy'
  resources :users
  resources :logins
  resources :documents
  resources :account_activations, only: [:edit]

end
