Rails.application.routes.draw do
  root 'users#index'
  get '/register' => 'users#register'

  get '/create',  to: redirect(path: '/register')
  post 'create' => 'users#create'

  get '/login', to: redirect(path: '/')
  post 'login' => 'users#login'

  get '/music' => 'musics#index'
  get '/save', to: redirect(path: '/music')
  get '/rank' => 'musics#rank'
  post 'save' => 'musics#save'
  get '/exit' => 'musics#exit'
  get '/search' => 'musics#search'

  get '/list' => 'favorites#index'
  get '/add/:id' => 'favorites#add'
  get '/remove/:id' => 'favorites#remove'
  get '/favorites' => 'favorites#favorites'
  post '/find' => 'favorites#find'
  get '/quit' => 'favorites#quit'
end
