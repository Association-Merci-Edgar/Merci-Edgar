module Geonames
  class Loader    
    def load_postal_codes
      File.open(File.join(Rails.root, 'db', 'geonames_FR.txt'), 'r') do |f|
        f.each_line do |line|
          next if line.match(/^#/) || line.match(/^iso/i)
          postal_code_mapping = Mappings::PostalCode.new(line.chomp)
          place = GeonamesPostalCode.where(postal_code: postal_code_mapping[:postal_code], place_name: postal_code_mapping[:place_name]).first_or_initialize
          place.attributes = postal_code_mapping
          place.save!
        end
      end
    end
  end
end