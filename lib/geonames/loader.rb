require 'benchmark'
module Geonames
  class Loader    
    def load_geonames(geoname_filename)
      Benchmark.bm do |x|
        x.report { empty_geonames }
        x.report {
          headers = [:country_code, :postal_code, :place_name, :admin_name1, :admin_code1, :admin_name2, :admin_code2, :admin_name3, :admin_code3, :latitude, :longitude, :accuracy]
          options = { convert_values_to_numeric: false, headers_in_file: false, user_provided_headers: headers, col_sep: "\t", force_simple_split: true, strip_chars_from_headers: /[\-"]/ }
          n = SmarterCSV.process(geoname_filename, options ) do |array|
            begin
              GeonamesPostalCode.create(array.first)
            rescue ActiveRecord::StatementInvalid
            end
          end
        }
      end
    end
    
    private
    def empty_geonames
      GeonamesPostalCode.delete_all
    end
    
  end
end