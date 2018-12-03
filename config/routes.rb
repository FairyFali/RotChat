Rails.application.routes.draw do
  get 'machines/index'
  get 'machines/show'
  get 'chats/index'
  resources :lists
  devise_for :users
  get 'welcome/index'
  
  # 聊天室
  resources :chats
  # 机器人管理信息的URL
  resources :machines do
    collection do
      get :index_json
    end
  end
  # 机器人评分
  post 'machines/score', to: 'machines#score'

  # 机器人回复信息的URL
  resources :machine_messages
  # 增加用户的机器人好友
  post 'machineusers' => 'machines_users#add'
  # 管理员机器人管理
  get '/admin/machines', to: 'machines_admin#index'
  post '/admin/machines', to: 'machines_admin#create'
  get '/admin/machines/new', to: 'machines_admin#new'
  get '/admin/machines/:id(.:format)', to: 'machines_admin#show'
  put '/admin/machines', to: 'machines_admin#update'
  patch '/admin/machines', to: 'machines_admin#update'
  delete '/admin/machines/:id(.:format)', to: 'machines_admin#destroy'
  get '/admin/machines/:id/edit(.:format)', to: 'machines_admin#edit'


  # 根目录
  root 'home#index'
end
