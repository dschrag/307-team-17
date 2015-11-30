class InvitationController < ApplicationController
  def create
    if logged_in? && user.house?
      @invitation = Invitation.create(:user => current_user, :house => current_user.house)
    end
  end

  def show
    @invitation = Invitation.where(:token => params[:token]).first
    if @invitation.nil?
      render 'error'
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
end