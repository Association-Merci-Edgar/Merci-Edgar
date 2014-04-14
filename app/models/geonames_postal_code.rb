class GeonamesPostalCode < ActiveRecord::Base
  attr_accessible :country_code,:postal_code, :place_name, 
                  :admin_name1, :admin_code1, :admin_name2, :admin_code2, :admin_name3, :admin_code3,
                  :latitude, :longitude, :accuracy
                  
  scope :by_place_name, lambda { |city| where("lower(unaccent(place_name)) LIKE ?", "%#{city.downcase}%" )}
  
  def self.get_latitude_and_longitude(options)
    places = GeonamesPostalCode.order(:id)
    city = options[:city]
    country_code = options[:country_code] || "FR"
    postal_code = options[:postal_code]
    
    if city.present?
      city_pattern = city.strip.downcase.gsub(/st/,'saint')
      city_pattern = city_pattern.gsub(/[ -]/,'%')
      city_pattern = "%#{city_pattern}%"
      places = by_place_name(city_pattern)
    end
    
    if postal_code.present?
      places = places.where(postal_code: postal_code.strip)
    end
    
    if city.present? || postal_code.present?
      place = places.where(country_code: country_code).first
      place.attributes.slice("latitude","longitude") if place
    end
  end                
end