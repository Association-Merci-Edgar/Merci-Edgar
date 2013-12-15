class AddStyleTagsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :style_tags, :string
  end
end
