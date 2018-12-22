class ApplicationController < ActionController::Base
  	protected
  	# 验证当前用户是否是管理员
	def authenticate_admin
	  unless current_user.admin?
	    flash[:alert] = "Not allow!"
	    redirect_to root_path
	  end
	end
end
