class Structure < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :contact_attributes

  has_one :contact, as: :contactable
  accepts_nested_attributes_for :contact

  belongs_to :structurable, polymorphic: true

  has_many :people_structures
  has_many :people, through: :people_structures, uniq:true

  delegate :name, :tasks, :reportings, :addresses, :remark, :emails, :phones, :websites, :city, :address, :phone_number, :website, :website_url, :style_list, :network_list, :custom_list, :contacted?, :favorite?, to: :contact
  delegate :avatar, to: :structurable

  def add_person(first_name,last_name,title)
    p = Person.find_or_initialize_by_first_name_and_name(first_name:first_name,name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end

=begin
  def relative
    self.main_contact ||= self.people.first
  end
=end
end