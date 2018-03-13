Rails.application.routes.draw do
  get 'session/new'

	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'
  # get '/home', 	to 'static_pages#home'

  get '/help', 	to: 'static_pages#help' 
  
  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :users



end
