class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  before_create :create_token

end

public
def url
  '/i/' + self.token
end

private
def create_token
  begin
    self.token = SecureRandom.hex[0,8].downcase
  end while self.class.exists?(token: token)
end
