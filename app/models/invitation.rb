class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

end

before_create :add_token
private
def add_token
  begin
    self.token = SecureRandom.hex[0,8].lowercase
  end while self.class.exists?(token: token)
end
