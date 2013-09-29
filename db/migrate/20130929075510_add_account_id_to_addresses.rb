class AddAccountIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :account_id, :integer
    add_index :addresses, :account_id
    Address.unscoped.includes(:contact).each do |a|
      c = Contact.unscoped.find(a.contact_id)
      a.account_id = c.account_id
      a.save!
    end
  end
end
