Rails.application.routes.draw do
  get 'machines/index'
  get 'machines/show'
  get 'chats/index'
  resources :lists
  devise_for :users
  get 'welcome/index'
  
  resources :chats
  resources :machines do
    collection do
      get :index_json
    end
  end
  resources :machine_messages
  post '/machineusers' => 'machines_users#add'

  root 'home#index'
end
