class EventsController < ApplicationController
	before_action :logged_in_user

	def new
		@event = Event.new
		@event.permissions.build
	end

	def create
		# data = "event created"
		# send_data(data, :filename => "event.txt")
		@event = current_user.events.build(event_params)
		if @event.save
			@event.permissions.create(user_id: 0, level: 2)
			@perm_user = @event.permissions.create(user_id: current_user.id, level: 0)
			flash[:success] = "Event created"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def index
		@events = House.find(current_user.relationship.house_id).events
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

	def export
		@events = House.find(current_user.relationship.house_id).events
		file = ''
		file << "BEGIN:VCALENDAR\n"
		@events.each do |event|
			if event.permissions.find_by user_id: current_user.id
				perm = event.permissions.find_by user_id: current_user.id
			else
				perm = event.permissions.find_by user_id: 0
			end
			if perm.level == 0 || perm.level == 3
				file << "BEGIN:VEVENT\nDTSTART:" + event.start_time.strftime("%Y%m%dT%H%M%S") + "\nDTEND:" + event.end_time.strftime("%Y%m%dT%H%M%S") + "\nDESCRIPTION:" + event.description + "\nSUMMARY:" + event.name + "\nEND:VEVENT\n"
			end
		end
		file << "END:VCALENDAR"
		send_data file, :filename => current_user.name + 'Schedule.ics', :type => 'text/calendar'
	end

	private
		def event_params
			params.require(:event).permit(:name, :description, :start_time, :end_time, permissions_attributes: [:id, :user_id, :level])
		end
end
