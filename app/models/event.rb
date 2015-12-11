class Event < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :name, presence: true
	validates :description, presence: false
	validates :start_time, presence: true
	validates :end_time, presence: true
	has_many :permissions, as: :permissable, dependent: :destroy
	accepts_nested_attributes_for :permissions
end
