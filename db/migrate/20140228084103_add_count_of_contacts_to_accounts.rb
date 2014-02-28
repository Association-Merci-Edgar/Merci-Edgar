class AddCountOfContactsToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :contacts_count, :integer, default: 0
    

    Account.reset_column_information
    def Account.readonly_attributes; [] end

    say_with_time("Calculate contacts count by account...") do
      Contact.unscoped do
        Account.find_each do |a|
          Account.current_id = a.id
          a.update_attribute :contacts_count, a.contacts.length
          say("#{a.name} => #{a.contacts_count} contacts")
        end
      end
    end
  end
  def down
    remove_column :accounts, :contacts_count
  end
end
