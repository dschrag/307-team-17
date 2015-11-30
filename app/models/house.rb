class House < ActiveRecord::Base
	validates :name, presence: true
	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true, numericality: { only_integer: true }
	has_many :relationships
	has_many :users, :through => :relationships
	has_many :items, :through => :users
	has_many :notes, :through => :users
	has_many :permissions, as: :permissable, dependent: :destroy
end

def add_user(user)
	unless user.relationship.nil?
    user.relationship.destroy
  end
        
  @relationship = Relationship.create()
  user.relationship = @relationship
  this.relationships << @relationship
end