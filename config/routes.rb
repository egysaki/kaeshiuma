Rails.application.routes.draw do
  get "top/index"
  root "top#index"

  post '/callback' => 'webhook#callback'
end
