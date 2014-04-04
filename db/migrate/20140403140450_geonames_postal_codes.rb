class GeonamesPostalCodes < ActiveRecord::Migration
  def self.up
    # blah
    
    # # create countries
    create_table :geonames_postal_codes do |t|
      t.string :country_code, :null => false
      t.string :postal_code, :null => false
      t.string :place_name, :null => false
      t.string :admin_name1
      t.string :admin_code1
      t.string :admin_name2
      t.string :admin_code2
      t.string :admin_name3
      t.string :admin_code3
      t.float :latitude, :precision => 14, :scale => 8, :null => false
      t.float :longitude, :precision => 14, :scale => 8, :null => false
      t.integer :accuracy
    end
    
    add_index :geonames_postal_codes, :postal_code
  end
  
  def self.down
    # drop all the tables
    drop_table :geonames_postal_codes
  end
end
