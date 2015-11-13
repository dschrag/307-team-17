class Notification < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
 
	validates :type, presence: true

	validates :web, presence: true
	validates :mobile, presence: true
	validates :email, presence: true
end
