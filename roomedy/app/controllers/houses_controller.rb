class HousesController < ApplicationController
 	before_action :logged_in_user
 	before_action :is_admin, only: [:edit, :update]

 	def show
		@house = House.find(params[:id])
	end
	def new
		@house = House.new
  	end
	def create
		@house = House.new(house_params)
		@relationship = Relationship.create()
		current_user.relationship = @relationship
		@house.relationships << @relationship
		if @house.save
			if current_user.save(validate: false)
				flash[:success] = "Welcome to your new Home, #{current_user.name}"
				@perm_default = @house.permissions.create(user_id: 0, level: 1)
				@perm_user = @house.permissions.create(user_id: current_user.id, level: 0)
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

	private
		def house_params
			params.require(:house).permit(:name, :street, :city, :state, :zip)
		end

		def is_admin
			if @house.permissions.find_by user_id: current_user.id
				perm = @house.permissions.find_by user_id: current_user.id
			else
				perm = @house.permissions.first
			end

			unless perm == 0
				flash[:danger] = "You must be the house administrator to view this page"
				redirect_to root_path
			end
		end

end
