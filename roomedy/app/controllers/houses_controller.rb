class HousesController < ApplicationController
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
			else
				flash[:notice] = "Unable to save user"
			end
			redirect_to @house
		else
			render 'new'
		end
	end

	private
		def house_params
			params.require(:house).permit(:name, :street, :city, :state, :zip)
		end
end
