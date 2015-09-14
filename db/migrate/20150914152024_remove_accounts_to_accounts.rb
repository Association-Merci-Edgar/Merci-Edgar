class RemoveAccountsToAccounts < ActiveRecord::Migration
  # remove column created by mistake
  def change
    remove_column :accounts, :accounts
  end

end
