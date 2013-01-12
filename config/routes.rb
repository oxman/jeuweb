Jeuweb::Application.routes.draw do
  root to: 'topics#index'

  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  get '/topics/new', to: 'topics#new', as: 'new_topic'
end
