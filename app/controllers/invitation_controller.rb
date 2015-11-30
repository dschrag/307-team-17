class InvitationController < ApplicationController
  before_action :logged_in_user
  before_action :member_of_house, except: [:view]

  def create
    Invitation.destroy_all(:user => current_user)

    @invitation = Invitation.create(:user => current_user, :house => current_user.house)

    redirect_to :action => 'get'
  end

  def get
    @invitation = Invitation.where(:user => current_user).first
  end

  def view
    @invitation = Invitation.where(:token => params[:token]).first
    if !@invitation
      render 'error'
      return
    end
    @house = @invitation.house

    # If that partictular user does not belong to that house anymore.
    if @invitation.user.house != @house
      render 'error'
    end

    if logged_in? && params[:accept] == "true"
        @house.add_user(current_user)
    
        redirect_to @house
    end
  end

  private
  def member_of_house
    unless current_user.house
      flash[:danger] = "You cannot preform that method as you are not a member of a house."
      redirect_to root_path
    end
  end
end