# == Schema Information
#
# Table name: show_buyers
#
#  id         :integer          not null, primary key
#  licence    :string(255)
#  avatar     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShowBuyer < ActiveRecord::Base
  # default_scope { where(:account_id => Account.current_id) }

  attr_accessible :licence, :structure_attributes, :schedulings_attributes, :avatar
  has_one :structure, as: :structurable, dependent: :destroy
  accepts_nested_attributes_for :structure

  has_many :schedulings, autosave: true, order: "id ASC
  accepts_nested_attributes_for :schedulings, :reject_if => :all_blank, :allow_destroy => true

  has_many :show_hosts, through: :schedulings, uniq: true

  delegate :name, to: :structure

  mount_uploader :avatar, AvatarUploader

  delegate :name, :people, :tasks, :reportings, :remark, :addresses, :emails, :phones, :websites, :city, :address, :network_list, :custom_list, :contacted?, :favorite?, :main_person, to: :structure  

  before_update :set_contact_criteria 
  
  scope :by_contract, lambda { |tag_name| joins(:schedulings).where("schedulings.contract_tags LIKE ?", "%#{tag_name}%") }
  scope :by_style, lambda { |tag_name| joins(:schedulings).where("schedulings.style_tags LIKE ?", "%#{tag_name}%") }

  def fine_model
    self
  end

  def set_contact_criteria
    self.build_structure unless structure.present?
    self.structure.build_contact unless structure.contact.present?
    contact = structure.contact
    
    c_style_list = self.style_list
    contact.style_tags = c_style_list.join(',') if c_style_list.present?
    
    c_contract_list = self.contract_list
    contact.contract_tags = c_contract_list.join(',') if c_contract_list.present?
    
  end

  def contract_list
    cl = []
    self.schedulings.each do |s|
      s.contract_list.each do |c|
        cl.push(c) unless cl.include?(c)
      end
    end
    cl
  end

  def style_list
    sl = []
    self.schedulings.each do |s|
      s.style_list.each do |style|
        sl.push(style) unless sl.include?(style)
      end if s.style_list.present?
    end
    sl
  end

end
