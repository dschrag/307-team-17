class Note < ActiveRecord::Base
  belongs_to :user
  has_many :share_notes
  has_many :users, :through => :share_notes
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
end
