# Machine的管理controller，对Machine进行增删查改，只要管理员权限才能使用
class MachinesAdminController < ApplicationController
	before_action :set_machine, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	before_action :authenticate_admin # 再檢查是否有權限

	# GET /machines
	# GET /machines.json
	def index
		@machines = Machine.all
	end

	# GET /machines/1
	# GET /machines/1.json
	def show
	end

	# GET /machines/new
	def new
		@machine = Machine.new
	end

	# GET /machines/1/edit
	def edit
	end

	# POST /machines
	# POST /machines.json
	def create
		@machine = Machine.new(machine_params)
		@machine.req_num = 0
		@machine.duration = 0
		@machine.score = 90
		respond_to do |format|
		  if @machine.save
		    format.html { redirect_to '/admin/machines/' + @machine.id.to_s, notice: 'machine was successfully created.' }
		    format.json { render :show, status: :created, location: @machine }
		  else
		    format.html { render :new }
		    format.json { render json: @machine.errors, status: :unprocessable_entity }
		  end
		end
	end

	# PATCH/PUT /machines/1
	# PATCH/PUT /machines/1.json
	def update
		respond_to do |format|
		  if @machine.update(machine_params)
		    format.html { redirect_to '/admin/machines/'+@machine.id.to_s, notice: 'machine was successfully updated.' }
		    format.json { render :show, status: :ok, location: @machine }
		  else
		    format.html { render :edit }
		    format.json { render json: @machine.errors, status: :unprocessable_entity }
		  end
		end
	end

	# DELETE /machines/1
	# DELETE /machines/1.json
	def destroy
		@machine.destroy
		respond_to do |format|
		  format.html { redirect_to '/admin/machines', notice: 'machine was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white machine through.
    def machine_params
      params.require(:machine).permit(:api_key, :name, :url, :code)
    end
end
