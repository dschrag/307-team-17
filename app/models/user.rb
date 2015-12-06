class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false } #database max string size
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  scope :all_except_current, ->(user) { where.not(id: user) }
  has_one :relationship

  has_one :house, :through => :relationship
  has_many :activities
  has_many :notes, dependent: :destroy
  has_many :comments
  has_many :items
  has_many :events
  has_many :permissions
  has_many :transactions
  has_one :finance
  has_many :votes, dependent: :destroy
  has_many :vote_options, through: :votes

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", large: "480x480>" }, default_url: "missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment :avatar,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(String, cost: cost)
  end


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def voted_for?(poll)
    vote_options.any? {|v| v.poll == poll }
  end
end
