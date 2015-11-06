class InvitationController < ApplicationController
  def show
    @house = House.find_by_id(params[:id])
    if @house.nil?
      render 'error'
    end
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