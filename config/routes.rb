Jeuweb::Application.routes.draw do
  root to: 'topics#index'

  get    '/sign_in',  to: 'sessions#new'
  post   '/sign_in',  to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'


  get  '/sign_up', to: 'users#new'
  post '/users',   to: 'users#create'


  get  '/topics/search',    to: 'topics#search', as: 'topics_search'
  get  '/topics/new',       to: 'topics#new',    as: 'new_topic'
  get  '/topics/:id',       to: 'topics#show',   as: 'topic'
  get  '/topics/:id/edit',  to: 'topics#edit',   as: 'edit_topic'
  post '/topics/:id/tag',   to: 'topics#tag',    as: 'tag_topic'
  post '/topics/:id/score', to: 'topics#score',  as: 'score_topic'
  put  '/topics/:id',       to: 'topics#update', as: 'topic'
  post '/topics',           to: 'topics#create', as: 'topics'

  get  '/topics/:topic_id/replies/new',       to: 'replies#new',    as: 'new_topic_reply'
  get  '/topics/:topic_id/replies/:id/edit',  to: 'replies#edit',   as: 'edit_topic_reply'
  post '/topics/:topic_id/replies/:id/score', to: 'replies#score',  as: 'score_topic_reply'
  put  '/topics/:topic_id/replies/:id',       to: 'replies#update', as: 'topic_reply'
  post '/topics/:topic_id/replies',           to: 'replies#create', as: 'topic_replies'


  get  '/private_discussions',          to: 'private_topics#index',  as: 'private_topics'
  get  '/private_discussions/new',      to: 'private_topics#new',    as: 'new_private_topic'
  get  '/private_discussions/:id',      to: 'private_topics#show',   as: 'private_topic'
  post '/private_discussions',          to: 'private_topics#create', as: 'private_topics'
  get  '/private_discussions/:id/edit', to: 'private_topics#edit',   as: 'edit_private_topic'
  put  '/private_discussions/:id',      to: 'private_topics#update', as: 'private_topic'

  post '/private_discussions/:topic_id/participations', to: 'private_topics#create_participation', as: 'private_topic_participations'

  get  '/private_discussions/:topic_id/replies/:id/edit',  to: 'private_replies#edit',   as: 'edit_private_topic_reply'
  post '/private_discussions/:topic_id/replies/:id/score', to: 'private_replies#score',  as: 'score_private_topic_reply'
  put  '/private_discussions/:topic_id/replies/:id',       to: 'private_replies#update', as: 'private_topic_reply'
  post '/private_discussions/:topic_id/replies',           to: 'private_replies#create', as: 'private_topic_replies'
end
