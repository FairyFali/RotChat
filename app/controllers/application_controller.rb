class ApplicationController < ActionController::Base
	before_action :set_locale
 
 	# 国际化
	def set_locale
		session[:locale] = params[:locale] if params[:locale]  
 		I18n.locale = session[:locale] || I18n.default_locale
	end
  	protected
  	# 验证当前用户是否是管理员
	def authenticate_admin
	  unless current_user.admin?
	    flash[:alert] = "Not allow!"
	    redirect_to root_path
	  end
	end
end
