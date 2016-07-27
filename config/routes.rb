Rails.application.routes.draw do
  get 'users/new'

root  'docpages#home'

  get'about' => 'docpages#about'

  get 'support' => 'docpages#support'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
