class UserMailer < ApplicationMailer
  default from: "smithsp@purdue.edu"

  def register_email(user)
    @user = user
    @return_url = "roomedy.com/dashboard"
    mail(to: @user.email, subject: 'Welcome to Roomedy!')
  end
end
