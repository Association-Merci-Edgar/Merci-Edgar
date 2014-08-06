class ContactSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes  :id, :type, :name, :avatar_url, :city, :email_address, :phone_number, 
              :capacity_list, :style_list, :network_list, :custom_list, :contract_list, :venue_kind, :show_link, :edit_link
  has_many :people_structures
  
  def type
    fine_model.class.name
  end
  
  def avatar_url
    fine_model.avatar_url
  end
  
  def city
    object.address.try(:city)
  end
  
  def venue_kind
    fine_model.kind if fine_model.is_a? Venue
  end
  
  def show_link
    method_name = type.underscore + "_path"
    send(method_name, fine_model, locale: I18n.locale)
  end
  
  def edit_link
    method_name = "edit_" + type.underscore + "_path"
    send(method_name, fine_model, locale: I18n.locale)
  end
  
  def people_structures
    object.contactable.people_structures
  end
  
  private
  def fine_model
    @fine_model ||= object.fine_model
  end
end
