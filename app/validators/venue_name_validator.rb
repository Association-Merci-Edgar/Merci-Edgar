class VenueNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Venue.joins(:contact).where(:contacts => {:city => record.contact.city}, :venues => {:name => value}).blank?
      record.errors[attribute] << (options[:message] || "Une salle existe deja avec ce nom dans la ville de #{record.contact.city}")
    end
  end
end
