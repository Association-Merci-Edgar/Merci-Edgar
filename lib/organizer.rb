module Organizer
  def name_with_kind
    return nil unless self.name.present?
    "#{self.name} [#{self.class.model_name.human}]"
  end
end