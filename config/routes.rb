MyCookbook::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :destroy, :create]

  root :to => 'pages#home'
    
  # Pages
  match '/contact', :to => 'pages#contact'
  match '/home', :to => 'pages#home'
  match '/about', :to => 'pages#about'

  # Users
  match '/signup', :to => 'users#new'

  # Sessions
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

end
