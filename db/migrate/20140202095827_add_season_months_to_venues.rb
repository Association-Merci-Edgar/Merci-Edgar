class AddSeasonMonthsToVenues < ActiveRecord::Migration
  def up
    add_column :venues, :season_months, :string_array
    Venue.unscoped.find_each { |v| v.update_attributes!(:season_months => ModuloRange.new(v.start_season,v.end_season).to_a) if v.start_season && v.end_season }
  end
  
  def down
    add_column :venues, :start_season, :integer
    add_column :venues, :end_season, :integer
    remove_column :venues, :season_months
  end
end
