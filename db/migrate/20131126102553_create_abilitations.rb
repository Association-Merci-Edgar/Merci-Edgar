class CreateAbilitations < ActiveRecord::Migration
  def change
    create_table :abilitations do |t|
      t.integer :user_id
      t.integer :account_id
      t.string :kind, default: "member", null: false

      t.timestamps
    end
    
    convert_user_relationships
    
    drop_table :accounts_users
  end
  
  def convert_user_relationships
    User.module_eval do
      has_and_belongs_to_many :accounts
    end
    
    Account.module_eval do
      has_and_belongs_to_many :users
    end


    account_user_ids = Hash.new do |hash,key|
      hash[key] = []
    end    
    Account.includes(:users).all.each do |account|
      account.users.each do |user|
        account_user_ids[account.id] << user.id
      end
    end

    User.module_eval do
      has_many :accounts, through: :abilitations
      has_many :abilitations, dependent: :destroy
    end
    
    Account.module_eval do
      has_many :users, through: :abilitations
      has_many :abilitations, dependent: :destroy
    end

    account_user_ids.each do |account_id,user_ids|
      user_ids.each do |user_id|
        user = User.find(user_id)
        account = Account.find(account_id)
        puts "Migrating #{user.name} into account #{account.name}"
        account.users << user
      end
    end
  end
end
