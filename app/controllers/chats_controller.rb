class ChatsController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
  
  def index
  	# 聊天室首页应该展示：1、用户的机器人列表；2、聊天窗口；3、聊天室的信息
  	@user_machines = current_user.machines
  end

end
