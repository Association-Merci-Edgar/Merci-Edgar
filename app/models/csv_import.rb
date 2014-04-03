class CsvImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :filename


  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_contacts.map(&:valid?).all?
      imported_contacts.each(&:save!)
      true
    else
      imported_contacts.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_contacts
    @imported_contacts ||= load_imported_contacts
  end

  def load_csv_venue_file(filename, options = {})
    total_chunks = SmarterCSV.process(filename, chunk_size: 10) do |chunk|
      chunk.each do |venue_row|
        puts "row: #{venue_row}"
        venue = Venue.from_csv(venue_row)
        unless venue.save
          puts venue.errors.full_messages
          return
        end
      end
    end
  end

end
