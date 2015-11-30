class InvitationController < ApplicationController
  def create
    if logged_in?
      @invitation = Invitation.create(:user => current_user, :house => current_user.house)
    end
  end

  def show
    @invitation = Invitation.where(:token => params[:token]).first
    if @invitation.nil?
      render 'error'
    end
    @house = @invitation.house

    if logged_in? && params[:accept] == "true"
        unless current_user.relationship.nil?
          current_user.relationship.destroy
        end
        
        @relationship = Relationship.create()
        current_user.relationship = @relationship
        @house.relationships << @relationship
      
        redirect_to @house
    end
  end
end