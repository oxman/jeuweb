Jeuweb::Application.routes.draw do
  root to: 'topics#index'

  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  get  '/topics/new', to: 'topics#new',    as: 'new_topic'
  get  '/topics/:id', to: 'topics#show',   as: 'topic'
  post '/topics',     to: 'topics#create', as: 'topics'

  get  '/topics/:topic_id/replies/new',      to: 'replies#new',    as: 'new_topic_reply'
  get  '/topics/:topic_id/replies/:id/edit', to: 'replies#edit',   as: 'edit_topic_reply'
  post '/topics/:topic_id/replies',          to: 'replies#create', as: 'topic_replies'
end
