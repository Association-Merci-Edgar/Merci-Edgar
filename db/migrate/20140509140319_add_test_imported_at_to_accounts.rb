class AddTestImportedAtToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :test_imported_at, :integer
  end
end
