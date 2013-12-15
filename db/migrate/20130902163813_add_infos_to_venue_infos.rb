class AddInfosToVenueInfos < ActiveRecord::Migration
  def change
    add_column :venue_infos, :bar, :boolean
    add_column :venue_infos, :period, :string
    add_column :venue_infos, :accompaniment, :boolean
    add_column :venue_infos, :residency, :boolean
    add_column :venue_infos, :remark, :text
  end
end
