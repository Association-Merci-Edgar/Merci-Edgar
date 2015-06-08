class UserMailer < ActionMailer::Base
  default :from => ENV["EMAIL_ADDRESS"]

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
    headers['X-MC-GoogleAnalytics'] = ENV["DOMAIN"]
    headers['X-MC-Tags'] = "welcome"
  end
  
  def abilitation_instructions(account, manager, member)
    abilitation_email(account, manager, member)
  end
  
  def abilitation_notification(account, manager, member)
    abilitation_email(account, manager, member)
  end
  
  def contacts_import_email(user, options)
    @user = user
    @filename = options[:filename]
    @account = options[:account]
    @imported_at = options[:imported_at]
    mail(to: user.email, subject: "Import de contacts")
  end

  def contacts_import_invalid(user)
    @user = user
    mail(to: user.email, subject: "Problème lors de l'import Merci Edgar")
  end
  
  def contacts_import_error(user)
    @user = user
    mail(to: user.email, subject: "Problème lors de l'import Merci Edgar")
  end

  private
  def abilitation_email(account, manager, member)
    @account = account
    @manager = manager
    @member = member
    mail(:to => member.email, :subject => "Bienvenue dans la base de #{@account.name} (Merci Edgar)")    
  end  
  
end
