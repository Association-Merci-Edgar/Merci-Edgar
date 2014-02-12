ActiveAdmin.register User do

  sidebar "Abilitation Details", only: [:show, :edit] do
    ul do
      li link_to("Abilitations", admin_user_abils_path(user))
    end
  end

  index do
    column :id do |user|
      link_to user.id, admin_user_path(user)
    end
    
    columns_to_include = ["name","first_name", "last_name","current_sign_in_at", "last_sign_in_at", "created_at", "confirmed_at" ]
    columns_to_include.each do |c|
      column c.to_sym
    end

  end
  
end

ActiveAdmin.register Abilitation, as: "Abil" do
  belongs_to :user
  navigation_menu :user
  
  index do
    columns_to_include = [:id, :kind, :created_at, :updated_at]
    columns_to_include.each {|c| column c}
    column :account do |abilitation| 
      link_to abilitation.account.name, admin_account_path(abilitation.account) if abilitation.account
    end
  end
end
