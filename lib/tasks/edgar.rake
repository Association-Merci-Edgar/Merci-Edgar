namespace :edgar do
  desc "Create staff users"
  task :dream_team => :environment do
    dream_account = Account.create(name:"Base Edgar",domain:"community")
    krichtof = dream_account.users.build(name:"Christophe Robillard",email:"christophe.robillard@gmail.com",first_name:"Christophe",last_name:"Robillard",password:"changeme",password_confirmation:"changeme")
    jp = dream_account.users.build(name:"Jean-Paul Bagnis",email:"jp@jpbagnis.com",first_name:"Jean-Paul",last_name:"Bagnis",password:"changeme",password_confirmation:"changeme")
    krichtof.confirmed_at = Time.now
    jp.confirmed_at = Time.now
    if !dream_account.save
      logger.info "Error while creating staff users : #{dream_account.errors}"
    end
  end

  task :adone_team => :environment do
    adone_account = Account.create(name:"Compte Adone Test",domain:"adonetest")
    aurelie = adone_account.users.build(name:"Aurelie Thuot",email:"aurelie@label-adone.com",first_name:"Aurelie",last_name:"Thuot",password:"changeme",password_confirmation:"changeme")
    aline = adone_account.users.build(name:"Aline Texier",email:"aline@label-adone.com",first_name:"Aline",last_name:"Texier",password:"changeme",password_confirmation:"changeme")
    benoit = adone_account.users.build(name:"Benoit Falip",email:"benoit@label-adone.com",first_name:"Benoit",last_name:"Falip",password:"changeme",password_confirmation:"changeme")
    sylvie = adone_account.users.build(name:"Sylvie Samson",email:"sylvie@label-adone.com",first_name:"Sylvie",last_name:"Samson",password:"changeme",password_confirmation:"changeme")
    elodie = adone_account.users.build(name:"Elodie Baudouin",email:"elodie@label-adone.com",first_name:"Elodie",last_name:"Baudoin",password:"changeme",password_confirmation:"changeme")

    aurelie.confirmed_at = Time.now
    aline.confirmed_at = Time.now
    benoit.confirmed_at = Time.now
    sylvie.confirmed_at = Time.now
    elodie.confirmed_at = Time.now
    if !adone_account.save
      logger.info "Error while creating staff users : #{dream_account.errors}"
    end
    krichtof = User.find_by_email("christophe.robillard@gmail.com")
    krichtof.accounts << adone_account
  end

  task :populate => :environment do
    dream_account = Account.find_by_domain("community")
    Account.current_id = dream_account.id
    dream_account.import_contacts_from_csv("db/salles20.csv")
    adone_account = Account.find_by_domain("adonetest")
    Account.current_id = adone_account.id
    adone_account.import_contacts_from_csv("db/salles20.csv")
  end

end