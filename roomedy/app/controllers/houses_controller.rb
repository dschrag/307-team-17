class HousesController < ApplicationController
  def show
		@house = House.find(params[:id])
	end
	def new
		@house = House.new
  end
	def create
		@house = House.new(house_params)
		if @house.save
			flash[:success] = "Welcome to your new Home!"
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
