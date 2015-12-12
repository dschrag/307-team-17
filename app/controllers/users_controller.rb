class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]
  #before_action :has_house, except: [:new, :create]

  def show
  	@user = User.find_by(id: params[:id])
    @notes = @user.notes.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)

    puts "Creating finance"
	  if @user.save
      @user.finance = Finance.create(user_id: @user.id)
      log_in @user
	    flash[:success] = "Welcome!"

	    unless params[:user][:invite].nil?
        @invitation = Invitation.where(:token => params[:user][:invite]).first
        unless @invitation.nil?
          if @invitation.user.house == @invitation.house
            @invitation.house.add_user(@user)
          end
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

  def destroy
    # use either/or depending on your usecase
    @user.avatar = nil #Will remove the attachment and save the model
    @user.save #Will queue the attachment to be deleted
    redirect_to edit_user_path
  end

  private
  	def user_params
  	  params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :number, :bornon)
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
end
