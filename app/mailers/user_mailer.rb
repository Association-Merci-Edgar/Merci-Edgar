class UserMailer < ActionMailer::Base
  default :from => ENV["EMAIL_ADDRESS"]

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
    headers['X-MC-GoogleAnalytics'] = ENV["DOMAIN"]
    headers['X-MC-Tags'] = "welcome"
  end
  
  def abilitation_instructions(account, manager, member)
    @account = account
    @manager = manager
    @member = member
    mail(:to => member.email, :subject => "Rejoignez le groupe")
  end
end
