Rails.application.routes.draw do
  # get 'news/:query', to: 'application#news'
  get 'news', to: 'application#news'
  get 'joke', to: 'application#joke'
  get 'weather', to: 'application#weather'
  get 'error', to: 'application#error'
  # get 'google_dialogflow', to: 'application#google_dialogflow'
  get 'wit', to: 'application#wit'
  resources :apis
  resources :commands
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
