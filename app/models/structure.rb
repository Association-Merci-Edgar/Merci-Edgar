# == Schema Information
#
# Table name: structures
#
#  id                :integer          not null, primary key
#  structurable_id   :integer
#  structurable_type :string(255)
#  avatar            :string(255)
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Structure < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :contact_attributes, :avatar, :kind

  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact

  belongs_to :structurable, polymorphic: true

  has_many :relatives, dependent: :destroy

  has_many :people_structures
  has_many :people, through: :people_structures, uniq:true, dependent: :destroy

  delegate :name, :tasks, :reportings, :addresses, :remark, :emails, :phones, :websites, :city, :country,  :address, :phone_number, :website, :website_url, :network_list, :custom_list, :contacted?, :favorite?, to: :contact
  # delegate :avatar, to: :structurable

  mount_uploader :avatar, AvatarUploader
  
  validates_presence_of :contact
  validates_associated :contact


  def kind
    fm = self.fine_model
    if fm.present?
      fm.class.name.downcase
    end
  end
  
  def kind=(k)
    unless structurable.present?
      case k
      when "venue"
        self.structurable = Venue.new
      when "festival"
        self.structurable = Festival.new
      when "show_buyer"
        self.structurable = ShowBuyer.new
      end
    end 
  end

  def fine_model
    self.structurable.present? ? self.structurable.fine_model : self
  end

  def add_person(first_name,last_name,title)
    p = Person.find_or_initialize_by_first_name_and_name(first_name:first_name,name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end

  def main_person(user)
    if self.people.any?
      self.relative(user).present? ? self.relative(user).person : self.people.first
    end
  end

  def set_main_person(user,person)
    rel = relative(user) || self.relatives.build(user: user)
    rel.person = person
    rel.save
  end


  def main_person?(user,person)
    person == self.main_person(user)
  end

  def relative(user)
    relative = self.relatives.where(user_id: user.id).first
  end
end
