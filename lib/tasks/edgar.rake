namespace :edgar do
  desc "Create staff users"
  task :dream_team => :environment do
    dream_account = Account.create(name:"community",domain:"community")
    krichtof = dream_account.users.build(name:"Christophe Robillard",email:"christophe.robillard@gmail.com",first_name:"Christophe",last_name:"Robillard",password:"changeme",password_confirmation:"changeme")
    jp = dream_account.users.build(name:"Jean-Paul Bagnis",email:"jp@jpbagnis.com",first_name:"Jean-Paul",last_name:"Bagnis",password:"changeme",password_confirmation:"changeme")
    krichtof.confirmed_at = Time.now
    jp.confirmed_at = Time.now
    if !dream_account.save
      logger.info "Error while creating staff users : #{dream_account.errors}"
    end
  end

  task :populate => :environment do
    dream_account = Account.find_by_domain("community")
    Account.current_id = dream_account.id
    dream_account.import_contacts_from_csv("db/salles.csv")
  end

end