class AddDuplicateToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :duplicate_id, :integer
    add_index :contacts, :duplicate_id
  end
end
