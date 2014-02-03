ActiveAdmin.register Venue do
  sidebar "Venue Details", only: [:show, :edit] do
    ul do
      li link_to("Schedulings", admin_venue_schedulings_path(venue))
    end
  end
  index do
    column :id do |venue|
      link_to venue.id, admin_venue_path(venue)
    end
    
    columns_to_exclude = ["avatar","id"]
    (Venue.column_names - columns_to_exclude).each do |c|
      column c.to_sym
    end
    
    column :avatar do |venue|
      image_tag venue.avatar_url(:thumb)
    end
  end
  
  
end

ActiveAdmin.register Scheduling do
  belongs_to :venue
  navigation_menu :venue
end
