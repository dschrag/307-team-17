class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  include SessionsHelper

  include PublicActivity::StoreController

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end

    def has_house
      unless !current_user.relationship.nil?
        flash[:danger] = "You must have a house to access that feature"
        redirect_to root_path
      end
    end
end
