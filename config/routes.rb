Rails.application.routes.draw do
  get 'machines/index'
  get 'machines/show'
  get 'chats/index'
  resources :lists
  devise_for :users
  get 'welcome/index'
  
  resources :chats
  resources :machines
  resources :machine_messages
  get '/machines/index_json' => 'machines#index_json'
  post '/machineusers' => 'machines_users#add'

  root 'home#index'
end
