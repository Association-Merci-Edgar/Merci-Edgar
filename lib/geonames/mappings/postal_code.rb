module Geonames
  module Mappings
    class PostalCode < Base
    def mappings
      {
        :country_code => 0,
        :postal_code => 1,
        :place_name => 2,
        :admin_name1 => 3,
        :admin_code1 => 4,
        :admin_name2 => 5,
        :admin_code2 => 6,
        :admin_name3 => 7,
        :admin_code3 => 8,
        :latitude => 9,
        :longitude => 10,
        :accuracy => 11
      }
    end
    end
  end
end