class AddImportedAtAndSourceToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :imported_at, :datetime
    add_column :contacts, :source, :string
  end
end
