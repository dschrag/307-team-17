class EventsController < ApplicationController
	before_action :logged_in_user

	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:success] = "Event created"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def index
		@events = Event.paginate(page: params[:page])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			flash[:success] = "Event successfully updated"
			redirect_to events_path
		else
			render 'edit'
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		flash[:success] = "Event successfully deleted"
		redirect_to events_path
	end

	private
		def event_params
			params.require(:event).permit(:name, :description, :start_time, :end_time)
		end
end
