# 用户个人信息Controller
class UserProfilesController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入

  # 展示用户个人信息
  def show
  end

  # 编辑用户个人信息
  def edit
  	@user = current_user
  end

  # 更新用户个人信息
  def update
  	@user = current_user
  	respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/user_profiles/show', 
        			  notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # /user_profiles/upload_img
  # 上传用户头像
  def upload_img
  	image = params[:img][:image];
  	unless request.get?
  	filename = uploadfile(image)
  	current_user.update('img_url':filename)
  	end
  	flash[:notice] = "上传头像成功"
  	redirect_to '/user_profiles/edit'
  end

private
  
  # 获得前端上传的用户数据的参数信息
  def user_params
      params.require(:user).permit(:img_url, :nickname, :sex, :birthdate, 
								   :phone, :university, :address, :profession,
								   :memo)
  end

  # 上传文件
  # 上传头像图片
  def uploadfile(file)
    if !file.original_filename.empty?
      @filename = file.original_filename
      #设置目录路径，如果目录不存在，生成新目录
      img_dir = "#{Rails.root}/app/assets/images/upload/"
      FileUtils.mkdir(img_dir) unless File.exist?(img_dir)
      #写入文件
      ##wb 表示通过二进制方式写，可以保证文件不损坏
      File.open(img_dir + "#{@filename}", "wb") do |f|
        f.write(file.read)
      end
      return @filename
    end
  end

end
