class XmlImportWorker
  include SidekiqStatus::Worker

  def perform(account_id, xml_file_url, custom_tags)
    Account.current_id = account_id
    self.total = 50
    at(5,"Recup du fichier ...")
    uploader = XmlImportUploader.new
    uploader.retrieve_from_store!(File.basename(xml_file_url))
    uploader.cache_stored_file!
    at(10,"Lecture du fichier")
    xml = File.read(uploader.file.path)
    at(20, "Import ...")

    attributes = Hash.from_xml(xml)
    imported_at = Time.zone.now.to_i

    people = attributes["merciedgar"].delete("person")
    if people.is_a?(Array)
      people.each do |person_attributes|
        person = Person.from_merciedgar_hash(person_attributes, imported_at)
        person.contact.add_custom_tags(custom_tags) if custom_tags.present?
        person.save
        puts "La person #{person.name} a ete importee"
      end
    else
      if people.is_a?(Hash)
        person_attributes = people
        person = Person.from_merciedgar_hash(person_attributes, imported_at)
        person.contact.add_custom_tags(custom_tags) if custom_tags.present?
        person.save
        puts "La person #{person.name} a ete importee"
      end
    end
    
    venues = attributes["merciedgar"].delete("venue")
    if venues.is_a?(Array)
      venues.each do |venue_attributes|
        venue = Venue.from_merciedgar_hash(venue_attributes, imported_at)
        venue.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        venue.save
        puts "Le lieu #{venue.name} a ete importe"
      end
    else
      if venues.is_a?(Hash)
        venue_attributes = venues
        venue = Venue.from_merciedgar_hash(venue_attributes, imported_at)
        venue.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        venue.save
        puts "Le lieu #{venue.name} a ete importe"
      end
    end
    
    festivals = attributes["merciedgar"].delete("festival")
    if festivals.is_a?(Array)
      festivals.each do |festivals_attributes|
        festival = Festival.from_merciedgar_hash(festival_attributes, imported_at)
        festival.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        festival.save
        puts "Le festival #{venue.name} a ete importe"
      end
    else
      if festivals.is_a?(Hash)
        festival_attributes = festivals
        festival = Festival.from_merciedgar_hash(festival_attributes, imported_at)
        festival.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        festival.save
        puts "Le festival #{festival.name} a ete importe"
      end
    end

    show_buyers = attributes["merciedgar"].delete("show_buyer")
    if show_buyers.is_a?(Array)
      show_buyers.each do |show_buyer_attributes|
        show_buyer = ShowBuyer.from_merciedgar_hash(show_buyer_attributes, imported_at)
        show_buyer.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        show_buyer.save
        puts "Le lieu #{show_buyer.name} a ete importe"
      end
    else
      if show_buyers.is_a?(Hash)
        show_buyer_attributes = show_buyers
        show_buyer = ShowBuyer.from_merciedgar_hash(show_buyer_attributes, imported_at)
        show_buyer.structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        show_buyer.save
        puts "L'organisateur #{show_buyer.name} a ete importe"
      end
    end

    structures = attributes["merciedgar"].delete("structure")
    if structures.is_a?(Array)
      structures.each do |structure_attributes|
        structure = Structure.from_merciedgar_hash(structure_attributes, imported_at)
        structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        structure.save
        puts "Le lieu #{structure.name} a ete importe"
      end
    else
      if structures.is_a?(Hash)
        structure_attributes = structures
        structure = Structure.from_merciedgar_hash(structure_attributes, imported_at)
        structure.contact.add_custom_tags(custom_tags) if custom_tags.present?
        structure.save
        puts "La structure #{structure.name} a ete importe"
      end
    end

    imported_contacts = Contact.where(imported_at: imported_at)
    nb_duplicates = imported_contacts.where("duplicate_id IS NOT NULL").count
    nb_imported_contacts = imported_contacts.count
    
    self.payload = { nb_imported_contacts: nb_imported_contacts, nb_duplicates: nb_duplicates, imported_at: imported_at }


    at(99, "Import termine")
  end
end
  