class EventsController < ApplicationController
	before_action :logged_in_user

	def new
		@event = Event.new
		@event.permissions.build
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			@perm_user = @event.permissions.create(user_id: current_user.id, level: 0)
			flash[:success] = "Event created"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def index
		@events = current_user.events
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		permparams = (params[:event][:permission].permit!)
		permparams.each_key do |key|
			perm = Permission.find(key)
			perm.level = permparams[key][:level]
			perm.save
		end

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
			params.require(:event).permit(:name, :description, :start_time, :end_time, permissions_attributes: [:id, :user_id, :level])
		end
end
