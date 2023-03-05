# User Authentication routes.

resources :users, except: %i[new]
get '/signup', to: 'users#new'
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#logout'
