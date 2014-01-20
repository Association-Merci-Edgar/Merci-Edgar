class XmlExportWorker
  include SidekiqStatus::Worker

  def perform(account_id, params)
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
        contact_xml = contact.fine_deep_xml
        xml << contact_xml if contact_xml
        index += 1
        at(index, "Le contact #{contact.name} exporte")
      end
      
      contact_structures.find_each do |contact|
        contact_xml = contact.fine_deep_xml
        xml << contact_xml if contact_xml
        index += 1
        at(index, "Le contact #{contact.name} exporte")
      end
      
    end
    xml_data = xml.target!
    xml_file = AppSpecificStringIO.new(filename, xml_data)
    uploader = XmlExportUploader.new(Account.current_id.to_s)
    uploader.store!(xml_file)
    self.payload = uploader.url
  end
end
  