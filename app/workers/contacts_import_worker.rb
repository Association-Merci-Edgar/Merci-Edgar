require 'xml'
class ContactsImportWorker
  include SidekiqStatus::Worker
  sidekiq_options retry: false

  def perform(account_id, filename, options)
    Account.current_id = account_id
    user = User.find(options["user_id"])
    uploader = ContactsImportUploader.new(account_id.to_s)
    uploader.retrieve_from_store!(filename)
    uploader.cache_stored_file!
    at(10,"Lecture du fichier")
    imported_at = Time.zone.now.to_i
    test_mode = options["test_mode"]
    current_account = Account.find(account_id)
    current_account.destroy_test_contacts
    current_account.test_imported_at = test_mode ? imported_at : nil
    current_account.save!
    
    case File.extname(filename)
    when ".xml"
      import_xml_file(uploader.file, imported_at, options)
    when ".csv"
      log_message = import_csv_file(uploader.file, imported_at, options)
    end
    
    imported_contacts = Contact.where(imported_at: imported_at)
    nb_duplicates = imported_contacts.where("duplicate_id IS NOT NULL").count
    nb_imported_contacts = imported_contacts.count
    nb_imported_contacts
    self.payload = { nb_imported_contacts: nb_imported_contacts, nb_duplicates: nb_duplicates, imported_at: imported_at, message: log_message }
    UserMailer.contacts_import_email(user, { account: current_account, filename: filename, imported_at: imported_at }).deliver unless test_mode
  end
  
  def import_xml_file(file, imported_at, options)
    ActiveRecord::Base.transaction do
      File.open(file.path) do |io|
        self.total = io.size
        at(20, "Lecture du fichier ...")
        xml_reader = XML::Reader.io(io)
        xml_reader.read
        raise "No valid Merci Edgar File" unless xml_reader.name == "merciedgar"
      
        while xml_reader.read do
          case xml_reader.name
            when "show-buyer", "person", "structure"
              xml_node = xml_reader.expand.to_s
              attributes = Hash.from_xml(xml_node).fetch(xml_reader.name.underscore)
              instance = Object.const_get(xml_reader.name.underscore.camelize).from_merciedgar_hash(attributes, imported_at, options[:custom_tags])
              instance.save
              at(xml_reader.byte_consumed, "Ajout de la fiche #{instance.name}")                
          end
          xml_reader.next
        end
      end

      File.open(file.path) do |io|
        self.total = io.size
        at(20, "Lecture du fichier ...")
        xml_reader = XML::Reader.io(io)
        xml_reader.read
        raise "No valid Merci Edgar File" unless xml_reader.name == "merciedgar"
      
        while xml_reader.read do
          case xml_reader.name
            when "venue", "festival"
              xml_node = xml_reader.expand.to_s
              attributes = Hash.from_xml(xml_node).fetch(xml_reader.name.underscore)
              instance = Object.const_get(xml_reader.name.underscore.camelize).from_merciedgar_hash(attributes, imported_at, options[:custom_tags])
              instance.save
              at(xml_reader.byte_consumed, "Ajout de la fiche #{instance.name}")
                       
                
          end
          xml_reader.next 
        end
      end
    end
    
  end
  
  def get_lines(file_path)
    nb_lines = 0
    File.open(file_path) do |io|
      nb_lines = io.readlines.size
    end
    nb_lines
  end
  
  def import_csv_file(file, imported_at, options)
    imported_index = 0
    test_mode = options["test_mode"]
    nb_lines = get_lines(file.path)
    self.total = test_mode && 20 < nb_lines ? 20 : nb_lines
    log_message = ""
    total_chunks = SmarterCSV.process(file.path, chunk_size: 100, convert_values_to_numeric: {except: :code_postal}) do |chunk|
      chunk.each do |venue_row|
        imported_index += 1
        test_mode = options["test_mode"]
        return if imported_index > 20 && test_mode
        venue_row[:imported_at] = imported_at
        # venue_row[:first_name_last_name_order] = options[:first_name_last_name_order]
        venue_row[:first_name_last_name_order] = options["first_name_last_name_order"]
        
        venue, invalid_keys = Venue.from_csv(venue_row)
        if options["test_mode"]
          log_message << "#{venue_row[:nom]} en cours d'import...\n"
          log_message << ">> Problème dans les colonnes #{invalid_keys.join(',')}\n" if invalid_keys
          at(imported_index, log_message)
        end
        unless venue.save
          puts venue.errors.full_messages
          return
        end
      end
    end
    log_message    
  end
  
end
  