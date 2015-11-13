class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]
  before_action :has_house, except: [:new, :create]

  def show
  	@user = User.find(params[:id])
    @notes = @user.notes.paginate(page: params[:page])
  end
  def new
  	@user = User.new
  end
  def create
    @user = User.new(user_params)
	  if @user.save
      log_in @user
	    flash[:success] = "Welcome!"
	    
      default_notificaiton()

	    unless params[:user][:invite].nil?
        @house = House.find_by_id(params[:user][:invite])
        unless @house.nil? 
          @relationship = Relationship.create()
          @user.relationship = @relationship
          @house.relationships << @relationship
        end
      end
	    
	    redirect_to root_path
	  else
	    render 'new'
	  end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def user_params
  	  params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def default_notifications
      @user.notification.create(user: @user.id, type: "note_created", web: true, mobile: true, email:false)

      @user.notification.create(user: @user.id, type: "inventory_item_created", web: true, mobile: false, email:false)

      @user.notification.create(user: @user.id, type: "financial_transaction_created", web: true, mobile: false, email:true)
      @user.notification.create(user: @user.id, type: "financial_transaction_edited", web: true, mobile: false, email:false)
      @user.notification.create(user: @user.id, type: "financial_transaction_resolved", web: true, mobile: false, email:true)

      @user.notification.create(user: @user.id, type: "house_new_user", web: true, mobile: false, email:true)
      @user.notification.create(user: @user.id, type: "house_user_leave", web: false, mobile: false, email:true)
      @user.notification.create(user: @user.id, type: "house_new_admin", web: false, mobile: false, email:true)

      @user.notification.create(user: @user.id, type: "user_update_details", web: false, mobile: false, email:true)
      @user.notification.create(user: @user.id, type: "user_update_password", web: false, mobile: false, email:true)

      @user.notification.create(user: @user.id, type: "house_update_admin", web: true, mobile: false, email:false)
      @user.notification.create(user: @user.id, type: "house_update_name", web: true, mobile: false, email:false)

      @user.notification.create(user: @user.id, type: "event_reminder", web: true, mobile: true, email:true)
      @user.notification.create(user: @user.id, type: "event_created", web: true, mobile: false, email:true)
      @user.notification.create(user: @user.id, type: "event_invite", web: true, mobile: true, email:true)
    end
end
