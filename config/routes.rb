Rails.application.routes.draw do

  root  'docpages#home'

  get'about' => 'docpages#about'

  get 'support' => 'docpages#support'
  get 'join' => 'users#new'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
