class AddStartSchedulingAndEndSchedulingToVenueInfo < ActiveRecord::Migration
  def change
    add_column :venue_infos, :start_scheduling, :string
    add_column :venue_infos, :end_scheduling, :string
  end
end
