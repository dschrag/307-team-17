class HousesController < ApplicationController
 	before_action :logged_in_user
 	before_action :member_of_house, except: [:new, :create]
 	before_action :is_admin, only: [:edit, :update, :remove]

 	def show
		@house = House.find(params[:id])
	end
	def new
		@house = House.new
  	end
	def create
		@house = House.new(house_params)
		@house.permissions.build

		@house.add_user(current_user)
		
		if @house.save
			@house.permissions.create(user_id: 0, level: 1)
			@house.permissions.create(user_id: current_user.id, level: 0)
			if current_user.save(validate: false)
				flash[:success] = "Welcome to your new Home, #{current_user.name}"
			else
				flash[:notice] = "Unable to save user"
			end
			redirect_to @house
		else
			render 'new'
		end
	end

	def edit
		@house = House.find(params[:id])
	end

	def update
		@house = House.find(params[:id])
		if @house.update_attributes(house_params)
			flash[:success] = "House information updated"
			redirect_to @house
		else
			render 'edit'
		end
	end

	def remove
		@house = House.find(params[:id])
		@house.relationships.find_by(user_id: params[:user_id]).destroy
		flash[:success] = "User Removed"
		redirect_to @house
	end

	def promote
		@house = House.find(params[:id])
		@house.permissions.find_by(user_id: current_user.id).destroy
		@house.permissions.create(user_id: params[:user_id], level: 0)
		flash[:success] = "User promoted to Admin"
		redirect_to @house
	end

	private
		def house_params
			params.require(:house).permit(:name, :street, :city, :state, :zip)
		end

		def is_admin
			@house = House.find(params[:id])
			if @house.permissions.find_by user_id: current_user.id
				perm = @house.permissions.find_by user_id: current_user.id
			else
				perm = @house.permissions.first
			end

			unless perm.level == 0
				flash[:danger] = "You must be the house administrator to view this page"
				redirect_to @house
			end
		end

		def member_of_house
			@house = House.find(params[:id])
			unless @house.relationships.find_by(user_id: current_user.id)
				flash[:danger] = "You are not a member of that house and may not perform that task"
				redirect_to root_path
			end
		end
end
