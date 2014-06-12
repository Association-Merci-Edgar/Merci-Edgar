class AddDeptRegionToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :admin_name1, :string
    add_column :addresses, :admin_name2, :string
    add_index :addresses, :admin_name1
    add_index :addresses, :admin_name2
  end
end
