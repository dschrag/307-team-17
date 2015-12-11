class EventsController < ApplicationController
	before_action :logged_in_user

	def new
		@event = Event.new
		@event.permissions.build
	end

	def create
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

	def import
	end

	def store
		uploaded_file = params[:file]
		if uploaded_file.nil?
			flash[:danger] = "No file was selected for upload"
			render 'import' and return
		end
		file_content = uploaded_file.read
		lines = file_content.split("\n");
		if lines.first.strip != 'BEGIN:VCALENDAR'
			flash[:danger] = "File was not .ics format."
			render 'import'
		else
			count = 0
			inevent = false
			lines.each do |line|
				line = line.strip
				parts = line.split(":")
				if parts[0] == "BEGIN" && parts[1] == "VEVENT"
					inevent = true
					@event = Event.new
					@event = current_user.events.build
				elsif parts[0] == "DTSTART" && inevent
					@event.start_time = DateTime.strptime(parts[1], "%Y%m%dT%H%M%S")
				elsif parts[0] == "DTEND" && inevent
					@event.end_time = DateTime.strptime(parts[1], "%Y%m%dT%H%M%S")
				elsif parts[0] == "DTSTART;VALUE=DATE" && inevent
					@event.start_time = DateTime.strptime(parts[1], "%Y%m%d")
				elsif parts[0] == "DTEND;VALUE=DATE" && inevent
					@event.end_time = DateTime.strptime(parts[1], "%Y%m%d")
				elsif parts[0] == "DESCRIPTION" && inevent
					@event.description = parts[1]
				elsif parts[0] == "SUMMARY" && inevent
					@event.name = parts[1]
				elsif parts[0] == "END" && parts[1] == "VEVENT"
					inevent = false
					if @event.save
						count += 1
						@event.permissions.create(user_id: 0, level: 2)
						@perm_user = @event.permissions.create(user_id: current_user.id, level: 0)
					else
						puts @event.to_json
						flash[:danger] = "Event could not save correctly"
						render 'import' and return
					end
				end
			end
			flash[:success] = "#{count} " + 'event'.pluralize(count) + ' added.'
			redirect_to events_path
		end
	end

	private
		def event_params
			params.require(:event).permit(:name, :description, :start_time, :end_time, permissions_attributes: [:id, :user_id, :level])
		end
end
