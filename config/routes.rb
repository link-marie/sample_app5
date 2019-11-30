Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'  # 名前の変更が可能,  as: 'helf'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  
    # RESTfulなUsersリソースで必要となるすべてのアクションが利用できるようになる
  resources :users
end
