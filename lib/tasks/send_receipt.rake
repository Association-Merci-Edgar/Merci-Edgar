namespace :receipt do
  desc "send receipt for user"
  task "send" => [:environment] do
    accounts = Account.where('last_subscription_at IS NOT NULL')
    accounts.each do |account|
      puts "Sending official receipt to #{account.manager.name} from #{account.name}"
      UserMailer.subscription_official_receipt_email(account) 
    end
  end
end

def render_template(content, options)
  template = Liquid::Template.parse(content)
  template.render(options)
end

