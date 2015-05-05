class GeonamesPostalCode < ActiveRecord::Base
  attr_accessible :country_code,:postal_code, :place_name,
                  :admin_name1, :admin_code1, :admin_name2, :admin_code2, :admin_name3, :admin_code3,
                  :latitude, :longitude, :accuracy

  scope :by_place_name, lambda { |city_pattern| where("lower(place_name) LIKE ?", "#{city_pattern}" )}

  def self.get_latitude_longitude_and_admin_names(options)
    places = GeonamesPostalCode.order(:id)
    city = options[:city]
    country_code = options[:country_code] || "FR"
    postal_code = options[:postal_code]

    if city.present?
      city_pattern = city.strip.downcase.gsub(/st[ -]/,'saint%')
      city_pattern = I18n.transliterate(city_pattern)
      city_pattern = "%#{city_pattern}%"
      places = by_place_name(city_pattern)
    end

    if postal_code.present?
      places = places.where(postal_code: postal_code.strip)
    end

    if city.present? || postal_code.present?
      place = places.where(country_code: country_code).first
      place.attributes.slice("latitude","longitude", "admin_name1", "admin_name2") if place
    end
  end
end
