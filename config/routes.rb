Rails.application.routes.draw do
  get 'sessions/new'
  get '/signup',to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/help',to:'static_pages#help'
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  get '/news',to:'static_pages#news'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    member do 
      get :edit_pass
    end
  end
  
  #asでrootとpath名を指名できる
end
