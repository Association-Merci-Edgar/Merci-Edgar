class RenameVenueIdToVenueInfoIdToCapacities < ActiveRecord::Migration
  def up
    remove_column :capacities, :venue_id
    add_column :capacities, :venue_info_id, :integer
    add_index :capacities, :venue_info_id
  end

  def down
    remove_column :capacities, :venue_info_id
    add_column :capacities, :venue_id, :integer
    add_index :capacities, :venue_id
  end

end
