class Transaction < ActiveRecord::Base

	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :user
  monetize :price_cents
end
