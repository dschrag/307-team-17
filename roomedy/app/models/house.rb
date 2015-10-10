class House < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :address, presence: true, uniqueness: true
end
