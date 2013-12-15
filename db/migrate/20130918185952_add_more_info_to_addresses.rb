class AddMoreInfoToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :more_info, :text
  end
end
