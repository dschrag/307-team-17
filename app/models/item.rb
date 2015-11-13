class Item < ActiveRecord::Base

	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
	
    validates :item_price, presence: true, numericality: true
    validates :item_amount, presence: true, numericality: {only_integer: true}
    validates :item_name, presence: true
    
    belongs_to :user
    belongs_to :house
end