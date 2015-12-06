class House < ActiveRecord::Base
	validates :name, presence: true
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true, numericality: { only_integer: true }
	has_many :relationships
	has_many :users, :through => :relationships
	has_many :items, :through => :users
	has_many :notes
	has_many :permissions, as: :permissable, dependent: :destroy
	has_many :polls
end
