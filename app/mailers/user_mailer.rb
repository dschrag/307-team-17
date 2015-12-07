class UserMailer < ApplicationMailer
  default from: "smithsp@purdue.edu"

  def register_email(user)
    @user = user
    @return_url = "roomedy.com/dashboard"
    mail(to: @user.email, subject: 'Welcome to Roomedy!')
  end

  def invite_email(user, recipient_email, invite_url, optional_message)
    @user = user
    @recipient_email = recipient_email
    @invite_url = invite_url
    @optional_message = optional_message

    mail(to: @recipient_email, subject: @user.name + ", has invited you to Roomedy!")
  end
end
