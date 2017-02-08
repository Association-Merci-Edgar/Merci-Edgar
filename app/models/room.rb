class Room < ActiveRecord::Base
  belongs_to :venue, touch: true, inverse_of: :rooms
  has_many :capacities, :dependent => :destroy

  validates_numericality_of :depth, :height, :width, allow_nil:true
  validates_presence_of :venue

  attr_accessible :capacities_attributes, :bar, :depth, :height, :name, :width, :seating, :standing, :modular_space
  accepts_nested_attributes_for :capacities, :reject_if => proc { |attributes| attributes[:nb].blank? }, allow_destroy:true

  attr_localized :depth, :height, :width

  VALID_CSV_KEYS = [:places_debout, :places_assies, :modulable, :ouverture_plateau, :profondeur_plateau, :hauteur_plateau]

  def self.from_csv(row)
    room = Room.new
    room.name = row[:nom]

    extract_capacity_for(:places_debout, :standing, :places_debout_modulable)
    extract_capacity_for(:places_assises, :seating, :places_assises_modulable)

    room.width = row.delete(:ouverture_plateau) if row[:ouverture_plateau].is_a?(Integer)
    room.depth = row.delete(:profondeur_plateau) if row[:profondeur_plateau].is_a?(Integer)
    room.height = row.delete(:hauteur_plateau) if row[:hauteur_plateau].is_a?(Integer)
    room.bar = true if row.delete(:bar_salle).try(:downcase) == "x"
    room
  end

  def extract_capacity_for(type, kind, modular)
    capacity  = row.delete(type)
    if capacity.present? && capacity.is_a?(Integer) && capacity < Capacity::CAPACITY_MAX && capacity > 0
      standing_capacity = room.capacities.build(kind: kind, nb: capacity)
      standing_capacity.modular = true if row.delete(modular).try(:downcase) == "x"
    else
      row[type] = capacity if capacity.present?
    end
  end

  def to_csv
    [self.venue.name, ExportTools.build_list(self.venue.emails), ExportTools.build_list(self.venue.phones),
     ExportTools.build_list(self.venue.addresses), ExportTools.build_list(self.venue.websites),
     self.venue.translated_kind, self.venue.residency, self.venue.accompaniment,
     self.venue.network_list, self.venue.custom_list,
     self.venue.season_months, self.venue.style_list,
     self.venue.contract_list, self.venue.discovery,
     self.venue.translated_period, self.venue.scheduling_remark,
     self.venue.prospecting_months, self.venue.remark,
     self.name, self.seating, self.standing, self.modular_space,
     "#{self.depth || '?'} x #{self.width || '?'} x #{self.height || '?'}", self.bar, ExportTools.build_list(self.venue.people)
    ].to_csv
  end


end
