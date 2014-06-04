class AddGeocodedPreciselyToAddresses < ActiveRecord::Migration
  class Address < ActiveRecord::Base
  end
  
  def change
    add_column :addresses, :geocoded_precisely, :boolean, default: false
    Address.reset_column_information
    Address.unscoped.where("latitude IS NOT NULL and longitude IS NOT NULL").update_all(geocoded_precisely: true)
    add_index :addresses, :geocoded_precisely
  end
end
