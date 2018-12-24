Rails.application.routes.draw do
  get 'machines/index'
  get 'machines/show'
  get 'chats/index'
  resources :lists
  devise_for :users
  get 'welcome/index'

  # 远程调用controller， 无需权限
  get 'json/machines', to: 'json#search_machines'
  
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
  # 展示机器人
  get '/machines_profiles/:id', to: 'machines_profiles#show'

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

  # 用户个人中心
  get 'user_profiles/show'
  get 'user_profiles/edit'
  patch 'user_profiles', to: 'user_profiles#update'
  post 'user_profiles/upload_img', to: 'user_profiles#upload_img'

  # 与博客系统互相调用
  get 'machines/create/:id/blog', to: 'machines#create_blog'
  # get 'machines/gain/blog/comment/:id', to: 'machines#get_blog_comment'

  # 根目录
  root 'home#index'
end
