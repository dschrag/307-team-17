class ActivitiesController < ApplicationController
  def index
  	@activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: (House.find(current_user.relationship.house_id).users).all_except_current(current_user)).all
  end
end
