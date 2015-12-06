class VoteOption < ActiveRecord::Base
  belongs_to :poll
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  validates :title, presence: true
end
