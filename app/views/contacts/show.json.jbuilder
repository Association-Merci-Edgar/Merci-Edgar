json.contacts do
  fm = @contact.fine_model
  json.id @contact.id
  json.type fm.class.name
  json.name @contact.name
  json.avatar_url fm.avatar_url
  json.city @contact.address.city
  json.email_address @contact.email_address
  json.phone_number @contact.phone_number
  json.capacity_list @contact.capacity_list
  json.style_list @contact.style_list
  json.network_list @contact.network_list
  json.custom_list @contact.custom_list
  json.contract_list @contact.contract_list
  json.venue_kind fm.venue_kind if fm.is_a? Venue
  json.show_link venue_path(fm)
  json.edit_link edit_venue_path(fm)
end