class Note < ActiveRecord::Base

	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }

	has_one :poll
  belongs_to :user
  has_many :users
	has_many :comments
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  has_many :permissions, as: :permissable, dependent: :destroy
  accepts_nested_attributes_for :permissions

end
