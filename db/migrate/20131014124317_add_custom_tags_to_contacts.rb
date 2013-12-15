class AddCustomTagsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :custom_tags, :string
  end
end
