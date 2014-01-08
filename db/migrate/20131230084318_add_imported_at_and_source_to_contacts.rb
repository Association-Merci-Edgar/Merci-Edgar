class AddImportedAtAndSourceToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :imported_at, :integer
    add_column :contacts, :source, :string
  end
end
