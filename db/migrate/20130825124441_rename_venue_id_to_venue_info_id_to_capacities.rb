class RenameVenueIdToVenueInfoIdToCapacities < ActiveRecord::Migration
  def change
    rename_column :capacities, :venue_id, :venue_info_id
    rename_index :capacities, :venue_id, :venue_info_id
  end

end
