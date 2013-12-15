class AddPrincipalContactToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :main_contact_id, :integer
    add_index :contacts, :main_contact_id
  end
end
