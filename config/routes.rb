Rails.application.routes.draw do
  get '/signup',to: 'users#new'
  get '/help',to:'static_pages#help'
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  get '/news',to:'static_pages#news'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
  resources :users
  
  #asでrootとpath名を指名できる
end
