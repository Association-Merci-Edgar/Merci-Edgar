class AddNetworkTagsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :network_tags, :string
  end
end
