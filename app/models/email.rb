# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  kind       :string(255)
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Email < ActiveRecord::Base
  belongs_to :contact, touch:true
  attr_accessible :address, :kind, :specific_kind, :classic_kind
  validates_format_of :address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :message => "Not a valid email"

  before_validation :set_kind

  VENUE_KIND = [:reception, :scheduling, :administrative, :ticket, :technical, :other]
  PERSON_KIND = [:work, :perso, :other]
  EMAIL_KIND = [:reception, :scheduling, :administrative, :ticket, :technical, :work, :perso]

  def specific_kind
    self.kind unless kind_list.include?(self.kind.try(:to_sym))
  end

  def specific_kind=(special)
    @specific_kind = special if special.present?
    self.kind = @specific_kind
  end

  def kind_list
    EMAIL_KIND
  end

  def classic_kind
    case
    when self.kind.blank?
      kind_list[0]
    when kind_list.include?(self.kind.try(:to_sym))
      self.kind
    else
      :other
    end
  end

  def classic_kind=(classic)
    self.kind = classic
    @specific_kind = classic
  end

  def set_kind
    self.kind = @specific_kind if @specific_kind.present?
  end


end
