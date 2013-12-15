class AddAccountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :account_id, :integer
    add_index :tags, :account_id
  end
end
