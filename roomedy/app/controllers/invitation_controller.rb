class InvitationController < ApplicationController
  def show
    @house = House.find_by_id(params[:id])
    if @house.nil?
      render 'error'
    end
    if logged_in? && params[:accept] == "true"
        redirect_to @house
    end
  end
end