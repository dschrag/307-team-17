class House < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true, numericality: { only_integer: true }
end
