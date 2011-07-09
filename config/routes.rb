MyCookbook::Application.routes.draw do
  root :to => 'pages#home'
    
  # Pages
  match '/contact', :to => 'pages#contact'
  match '/home', :to => 'pages#home'
  match '/about', :to => 'pages#about'

end
