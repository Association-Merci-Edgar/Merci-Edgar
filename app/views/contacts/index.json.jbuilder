json.contacts do
  json.array!(@contacts) do |contact|
    fm = contact.fine_model
    json.id contact.id
    json.type fm.class.name
    json.name contact.name
    json.avatar_url fm.avatar_url
    json.city contact.address.city
    json.email_address contact.email_address
    json.phone_number contact.phone_number
    json.capacity_list contact.capacity_list
    json.style_list contact.style_list
    json.network_list contact.network_list
    json.custom_list contact.custom_list
    json.contract_list contact.contract_list
    json.venue_kind fm.kind if fm.is_a? Venue
    json.show_link venue_path(fm)
    json.edit_link edit_venue_path(fm)
    json.people_structures do
      json.array!(contact.contactable.people_structures) do |ps|
        json.id ps.id
        json.person ps.person_id
        json.structure ps.structure_id
        json.title ps.title
      end
    end
  end
end