class AddCriteriaToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :style_tags, :string
    add_column :contacts, :contract_tags, :string
    add_column :contacts, :capacity_tags, :string
    add_column :contacts, :venue_kind, :string
  end
end
