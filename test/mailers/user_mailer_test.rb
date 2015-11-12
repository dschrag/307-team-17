require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.new(name: "Derek Schrag", email: "dschrag@purdue.edu",
                      password: "testpasss",
                      password_confirmation: "testpasss")
  end

  test "registration" do
    email = UserMailer.register_email(@user)
    email.deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['smithsp@purdue.edu'], email.from
    assert_equal ['dschrag@purdue.edu'], email.to
    assert_equal 'Welcome to Roomedy!', email.subject

    #Unclear on how to test body of email.
  end

=begin

  test "invitation" do
    email = UserMailer.invite_email(@user, "smithsps@gmail.com")
    email.deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['smithsp@purdue.edu'], email.from
    assert_equal ['smithsps@gmail.com'], email.to
    assert_equal 'Derek Schrag has invited you to Roomedy!', email.subject
  end
=end
end