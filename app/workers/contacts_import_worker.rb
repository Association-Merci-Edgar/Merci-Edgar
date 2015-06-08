require 'xml'
class ContactsImportWorker
  include SidekiqStatus::Worker
  sidekiq_options retry: false

  def perform(import_id)
    import = ContactsImport.find(import_id.to_i)
    Account.current_id = import.account_id
    current_account = import.account
    raise "Un autre import est déjà en cours. Merci d'attendre qu'il soit terminé" if current_account.importing_now
    current_account.importing_now = true
    current_account.save!

    user = import.user
    at(1, "Préparation du fichier...")
    import.contacts_file.cache_stored_file!
    at(1, "Suppression des anciens contacts tests...")
    current_account.destroy_test_contacts
    imported_at = import.updated_at.to_i
    current_account.test_imported_at = import.test_mode ? imported_at : nil
    current_account.last_import_at = imported_at unless import.test_mode
    current_account.importing_now = true
    current_account.save!
    at(1, "Démarrage de l'import...")

    filename = import.contacts_file.filename
    case File.extname(filename)
    when ".xml"
      import_xml_file(import)
    else
      log_message, error = import_spreadsheet_file(import)
    end

    if error
      self.payload = { invalid_file: true, message: log_message }
      return

      self.payload = { message: error }

      UserMailer.contacts_import_invalid(user).deliver unless import.test_mode
    else
      imported_contacts = Contact.where(imported_at: imported_at)
      nb_duplicates = imported_contacts.where("duplicate_id IS NOT NULL").count
      nb_imported_contacts = imported_contacts.count
      self.payload = { nb_imported_contacts: nb_imported_contacts, nb_duplicates: nb_duplicates, imported_at: imported_at, message: log_message }
      UserMailer.contacts_import_email(user, { account: current_account, filename: import.filename, imported_at: imported_at }).deliver unless import.test_mode
    end
  rescue StandardError => e
    UserMailer.contacts_import_error(user).deliver unless import.test_mode
  ensure
    if current_account
      current_account.importing_now = false
      current_account.save!
      import.destroy unless import.test_mode
    end
  end

  def import_xml_file(import)
    file = import.contacts_file.file
    imported_at = import.updated_at.to_i
    options = {}
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

  def import_spreadsheet_file(import)
    ActiveRecord::Base.transaction do
      at(1,"Conversion du fichier...")

      spreadsheet = SpreadsheetFile.new(import.contacts_file.file.path, import.contacts_kind)
      if spreadsheet.invalid?
        log_message = spreadsheet.errors.messages.values.flatten.join(' / ')
        return [ log_message, :invalid_file ]
      end

      log_message = import.updated_at.to_i

      imported_index = 0
      test_mode = import.test_mode
      nb_lines = spreadsheet.nb_lines

      total = test_mode && 20 < nb_lines ? 20 : nb_lines
      log_message = ""
      at(1,"Lecture du fichier...")

      total_chunks = SmarterCSV.process(spreadsheet.csv_path, col_sep: spreadsheet.col_sep, chunk_size: 100, file_encoding: spreadsheet.file_encoding, convert_values_to_numeric: {only: [:places_assises, :places_debout, :places_mixte, :ouverture_plateau, :profondeur_plateau, :hauteur_plateau]}) do |chunk|
        chunk.each do |row|
          imported_index += 1
          return if imported_index > 20 && import.test_mode
          row[:imported_at] = import.updated_at.to_i
          row[:first_name_last_name_order] = import.first_name_last_name_order

          fine_contact, invalid_keys = spreadsheet.kind_klass.from_csv(row)
          if import.test_mode
            log_message << "#{row[:nom]} en cours d'import...\n"
            log_message << ">> Problème dans les colonnes #{invalid_keys.join(',')}\n" if invalid_keys.present?
            at(imported_index, log_message)
          end
          unless fine_contact.save
            puts fine_contact.errors.full_messages
            return
          end
        end
      end
      log_message
    end
  end

end

