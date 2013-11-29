# encoding: utf-8

# == Schema Information
#
# Table name: schedulings
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  show_host_id   :integer
#  show_host_type :string(255)
#  show_buyer_id  :integer
#  scheduler_id   :integer
#  period         :string(255)
#  contract_tags  :string(255)
#  style_tags     :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Scheduling < ActiveRecord::Base
  belongs_to :show_host, polymorphic: true, autosave: true
  belongs_to :show_buyer, autosave: true
  belongs_to :scheduler, class_name: "Person", touch: true, autosave: true
  has_many :prospectings, dependent: :destroy

  attr_accessible :name, :period, :contract_list, :style_tags, :prospectings_attributes, :show_buyer_name, :show_host_name, :scheduler_name, :external_show_buyer
  attr_accessor :scheduler_name
  
  # attr_writer :external_show_buyer
  
  accepts_nested_attributes_for :prospectings, :reject_if => :all_blank, :allow_destroy => true
  
  validates :name, presence: true
  validates :external_show_buyer, presence: true
  
  before_save :set_show_buyer
  after_save :set_scheduler_function
  
  def to_s
    result = name
    result = [result, show_host.try(:name)].compact.join(" à ")
    result = [result, show_buyer.try(:name)].compact.join(" par ")
    result
  end
    
  def external_show_buyer=(value)
    @external_show_buyer = value
    self.show_buyer = nil if value == "Cette structure"
  end
  
  def external_show_buyer
    if show_buyer.present?
      "Un autre organisateur de spectacles"
    else
      "Cette structure"
    end
  end
  
  def show_host_name=(name)
    if name.present?
      show_host_structure = Structure.joins(:contact).where(structurable_type: ["Venue","Festival"], contacts:{name: name}).first_or_initialize
      if show_host_structure.new_record?
        self.show_host = Venue.new(structure_attributes: { contact_attributes: {name: name} })
      else
        self.show_host = show_host_structure.structurable
      end
    end
  end      

  def show_host_name
    self.show_host.try(:name)
  end
  
  
  def show_buyer_name=(name)
    if name.present? && @external_show_buyer != "Cette structure"
      self.show_buyer = ShowBuyer.joins(:structure => :contact).where(contacts: {name: name}).first_or_initialize
      self.show_buyer.build_structure.build_contact(name: name) if self.show_buyer.new_record?
    end
  end
  
  def show_buyer_name
    self.show_buyer.try(:name)
  end    
  
  def set_show_buyer
    self.show_buyer = nil if @external_show_buyer == "Cette structure"
  end
  
  def scheduler_name=(name)
    if name.present?
      self.scheduler = Person.joins(:contact).where(contacts: {name:name}).first_or_initialize
      if self.scheduler.new_record?
        words = name.split(' ').compact
        self.scheduler.first_name = words[0]
        self.scheduler.last_name = words[1]
      end
      # set_scheduler_function
    end
  end
  
  def scheduler_name
    self.scheduler.try(:name)
  end
  
  def set_scheduler_function
    if scheduler.present?
      self.show_buyer.present? ? s = self.show_buyer.structure : s = self.show_host.structure
      ps = s.people_structures.where(title:"Programmateur", person_id: scheduler.id).first_or_initialize
      if ps.new_record?
        ps.person = scheduler
        debugger
        ps.save
      end
    end
  end
      
      
  def making_prospecting?(m=nil)
    if prospectings.any?
      m ||= Time.zone.now.month
      return prospectings.any? do |s|
        m += 12 if s.end_month < s.start_month && m < s.start_month
        end_month = s.end_month < s.start_month ? s.end_month + 12 : s.end_month
        s.start_month <= m && end_month >= m
      end
    else
      return false
    end
  end

  def contract_list
    self.contract_tags.present? ? self.contract_tags.split(',') : []
  end

  def contract_list=(contracts)
    self.contract_tags = contracts.delete_if(&:empty?).join(',') if contracts.present?
  end

  def style_list
    self.style_tags.split(',') if self.style_tags.present?
  end

  def style_list=(styles)
    self.style_tags = styles.join(',') if styles.present?
  end


end
