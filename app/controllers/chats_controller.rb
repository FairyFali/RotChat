class ChatsController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
  
  # 和人聊天的chat，未实现
  def index
  	
  end

end
