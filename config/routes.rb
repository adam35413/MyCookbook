MyCookbook::Application.routes.draw do
  resources :users

  root :to => 'pages#home'
    
  # Pages
  match '/contact', :to => 'pages#contact'
  match '/home', :to => 'pages#home'
  match '/about', :to => 'pages#about'

  # Users
  match '/signup', :to => 'users#new'


end
