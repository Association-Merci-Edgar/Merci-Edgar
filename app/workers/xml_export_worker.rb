class XmlExportWorker
  include SidekiqStatus::Worker
  sidekiq_options retry: false

  def perform(account_id, params)
    last_contact = nil
    begin
      Account.current_id = account_id
      filename = ["export",Account.find(account_id).domain,Time.now.to_i].join('_')
      filename << ".xml"
    
      contact_people = Contact.advanced_search_for_people(params)
      contact_structures = Contact.advanced_search_for_structures(params)
      self.total = contact_people.size + contact_structures.size
      index = 0
      xml = Builder::XmlMarkup.new
      xml.instruct!
      xml.merciedgar do
        contact_people.find_each do |contact|
          last_contact = contact
          contact_xml = contact.fine_deep_xml
          xml << contact_xml if contact_xml
          index += 1
          at(index, "Contact #{contact.name} exporté")
        end
      
        contact_structures.find_each do |contact|
          last_contact = contact
          contact_xml = contact.fine_deep_xml
          xml << contact_xml if contact_xml
          index += 1
          at(index, "Contact #{contact.name} exporté")
        end
      
      end
      xml_data = xml.target!
      xml_file = AppSpecificStringIO.new(filename, xml_data)
      uploader = XmlExportUploader.new(Account.current_id.to_s)
      uploader.store!(xml_file)
      self.payload = uploader.url
  
    rescue
      raise "Problem during export with #{last_contact.name}"
    end
  end
end
  