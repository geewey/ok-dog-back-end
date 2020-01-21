Rails.application.routes.draw do
  # post 'weather_post', to: 'application#weather_post'
  post '/webhooks/weather' => 'webhooks#weather_request', format: :json
  
  get 'dialogflow/:query', to: 'application#dialogflow'
  
  # get 'news/:query', to: 'application#news'
  get 'news', to: 'application#news'
  get 'joke', to: 'application#joke'
  get 'weather', to: 'application#weather_get'
  get 'error', to: 'application#error'
  
  # get 'google_dialogflow', to: 'application#google_dialogflow'
  # get 'wit', to: 'application#wit'

  resources :apis, only: [:index, :show]
  resources :commands, only: [:index, :show]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
