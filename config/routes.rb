Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  get 'sessions/new'
  get '/signup',to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/help',to:'static_pages#help'
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  get '/news',to:'static_pages#news'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
  get '/microposts',to:'static_pages#home'
  get "/microposts/search",to:'microposts#search'
  get "/d_post",to: 'static_pages#d_post'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  

  
  resources :users do
    member do 
      get :edit_pass
      get :following, :followers
      get :bookmarks
    end
  end
  
  resources :microposts,only: [:show,:create, :destroy] do
    collection do
      post :post_form
    end
  end
  
  resources :comments , only: [:create,:destroy] 
    
  
  resources :relationships, only: [:create, :destroy] do
    member do
      delete :destroy_at_index
    end
    
    collection do
      post :create_at_index
    end
  end
  
  resources :microposts , shallow: true do
    resource :bookmarks, only: %i[create destroy]
  end
  
  
  #asでrootとpath名を指名できる
  
  resources :notifications, only: :index do 
    collection do
      delete :destroy_all
    end
  end
  
end
