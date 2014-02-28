ActiveAdmin.register Account do
  # menu :label => "Comptes"
  sidebar "Account Details", only: [:show, :edit] do
    ul do
      li link_to("Abilitations", admin_account_abilitations_path(account))
    end
  end
  

  index do
    column :id do |account|
      link_to account.id, admin_account_path(account)
    end

    columns_to_include = ["name","domain", "created_at", "contacts_count" ]
    columns_to_include.each do |c|
      column c.to_sym
    end


    column :abilitations do |account|
      link_to("Abilitations", admin_account_abilitations_path(account))
    end
  end
end

ActiveAdmin.register Abilitation do
  belongs_to :account
  navigation_menu :account
  
  index do
    columns_to_include = [:id, :kind, :created_at, :updated_at]
    columns_to_include.each {|c| column c}
    column :user do |abilitation| 
      link_to abilitation.user.name, admin_user_path(abilitation.user) if abilitation.user
    end
  end
end
