class AddSeasonAndModifySchedulingToVenueInfos < ActiveRecord::Migration
  def up
    add_column :venue_infos, :start_season, :integer
    add_column :venue_infos, :end_season, :integer
    remove_column :venue_infos, :start_scheduling
    remove_column :venue_infos, :end_scheduling
    add_column :venue_infos, :start_scheduling, :integer
    add_column :venue_infos, :end_scheduling, :integer
  end

  def down
    remove_column :venue_infos, :start_season
    remove_column :venue_infos, :end_season
    remove_column :venue_infos, :start_scheduling
    remove_column :venue_infos, :end_scheduling
    add_column :venue_infos, :start_scheduling, :string
    add_column :venue_infos, :end_scheduling, :string
  end
end
