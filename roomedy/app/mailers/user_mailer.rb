class UserMailer < ApplicationMailer
  default from: "smithsp@purdue.edu"

  def register_email(user)
    @user = user
    @return_url = "roomedy.com/dashboard"
    mail(to: @user.email, subject: 'Welcome to Roomedy!')
  end

  def invite_email(user, recipient_email)
    @user = user
    @recipient_email = recipient_email
    
    if @user.relationship.nil?
			puts "Sent your invite to " + recipient_email
		else
			puts "Unable to send invite without a house!"
			return 
    end
    
    @invitation_url = "roomedy.com/invitation/" + @user.relationship.house.id.to_s
    mail(to: @recipient_email, subject: @user.name + " has invited you to Roomedy!")
  end
end
