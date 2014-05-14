class AddLastImportAtToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :last_import_at, :integer
    add_column :accounts, :importing_now, :boolean
    add_index :accounts, :last_import_at
    add_index :accounts, :test_imported_at
  end
end
