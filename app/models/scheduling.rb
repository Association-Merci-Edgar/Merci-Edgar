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

  attr_accessible :name, :period, :remark, :discovery, :contract_tags, :contract_list, :style_tags, :prospecting_months, :show_buyer_name, :show_host_name, :show_host_kind, :scheduler_name, :external_show_buyer
  attr_accessor :scheduler_name
  
  # attr_writer :external_show_buyer
  
  # accepts_nested_attributes_for :prospectings, :reject_if => :all_blank, :allow_destroy => true
  
  validates :name, presence: true
  validates :external_show_buyer, presence: true
  
  before_save :format_styles, if: "style_tags_changed?"
  before_save :set_show_buyer
  after_save :set_scheduler_function
  after_save :update_styles
  
  CONTRACT_LIST = ["Co-realisation","Co-production","Cession","Location","Engagement","Autre"]
  
  def to_s
    result = name
    result = [result, show_host.try(:name)].compact.join(" à ")
    result = [result, show_buyer.try(:name)].compact.join(" par ")
    result
  end
  
  def prospecting_months_s
    prospecting_months.present? ? prospecting_months.map {|m| I18n.t("date.abbr_month_names")[m.to_i]}.join('-') : "Non renseigné"
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
  
  def show_host_kind=(kind)
    @show_host_kind = kind
  end
  
  def show_host_kind
    self.show_host.class.name if self.show_host
  end
  
  def show_host_name=(name)
    if name.present? && name != show_host_name && @show_host_kind
      show_host_structure = Structure.joins(:contact).where(structurable_type: ["Venue","Festival"], contacts:{name: name}).first_or_initialize
      if show_host_structure.new_record?
        self.show_host = Venue.new(structure_attributes: { contact_attributes: {name: name} }) if @show_host_kind == "Venue"
        self.show_host = Festival.new(structure_attributes: { contact_attributes: {name: name} }) if @show_host_kind == "Festival"
        self.show_host.save        
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
      if self.show_buyer.new_record?
        self.show_buyer.build_structure.build_contact(name: name) 
        self.show_buyer.save
      end
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
        scheduler.name = name
        scheduler.save
      end
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
        ps.save
      end
    end
  end
      
      
  def making_prospecting?(m=Time.zone.now.month)
    self.prospecting_months.present? ? self.prospecting_months.include?(m.to_s) : false
  end

  def contract_list
    self.contract_tags.present? ? self.contract_tags.split(',') : []
  end

  def contract_list=(contracts)
    self.contract_tags = contracts.delete_if(&:empty?).join(',') if contracts.present?
  end

  def style_list
    self.style_tags.split(',').map(&:strip).map(&:downcase) if self.style_tags.present?
  end

  def style_list=(styles)
    self.style_tags = styles.map(&:downcase).join(', ') if styles.present?
  end

  def update_styles
    # debugger
    Style.add_styles(style_list) if style_tags.present?
  end
  
  def format_styles
    self.style_tags = self.style_tags.split(',').map(&:strip).map(&:downcase).uniq.join(',') if self.style_tags.present?
  end
  
  def deep_xml(builder=nil)
    to_xml(builder: builder, :skip_instruct => true, :skip_types => true, except: [:id, :created_at, :updated_at, :scheduler_id, :show_host_id, :show_host_type, :show_buyer_id])  do |xml|
      xml.scheduler_name scheduler_name if scheduler_id
      xml.show_buyer_name show_buyer_name if show_buyer_id
    end
  end
  
  def self.from_merciedgar_hash(scheduling_attributes, imported_at)  
    show_buyer_name = scheduling_attributes.delete("show_buyer_name")
    show_host_name = scheduling_attributes.delete("show_host_name")
    scheduler_name = scheduling_attributes.delete("scheduler_name")
    
    prospecting_months = scheduling_attributes.delete("prospecting_months")
    if prospecting_months
      pmonths = prospecting_months.delete("prospecting_month")
      pmonths = [].push(pmonths.to_s) unless pmonths.is_a?(Array)
    end
    scheduling = Scheduling.new(scheduling_attributes)
    scheduling.show_buyer = Contact.where("name = ? or name LIKE ?", show_buyer_name, "#{show_buyer_name} #%").where(imported_at: imported_at).first.try(:fine_model) if show_buyer_name   
    scheduling.scheduler = Contact.where("name = ? or name LIKE ?", scheduler_name, "#{scheduler_name} #%").where(imported_at: imported_at).first.try(:fine_model) if scheduler_name
    scheduling.prospecting_months = pmonths
    scheduling
  end
end
