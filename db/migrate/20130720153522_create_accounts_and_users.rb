class CreateAccountsAndUsers < ActiveRecord::Migration
  def change
    create_table :accounts_users do |t|
      t.belongs_to :account
      t.belongs_to :user
    end
  end
end
