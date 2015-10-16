class InvitationController < ApplicationController
  def show
    @house = House.find_by_id(params[:id])
    if @house.nil?
      render 'error'
    end
  end
end