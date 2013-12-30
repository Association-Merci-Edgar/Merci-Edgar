xml.instruct!
xml.merciedgar do
  @contacts.each do |contact|
    contact_xml = contact.fine_deep_xml
    xml << contact_xml if contact_xml
  end
end