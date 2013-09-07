# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  phone            :string(255)
#  email            :string(255)
#  website          :string(255)
#  street           :string(255)
#  postal_code      :string(255)
#  state            :string(255)
#  city             :string(255)
#  country          :string(255)
#  contactable_id   :integer
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contact < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :emails_attributes, :phones_attributes, :addresses_attributes, :websites_attributes, :avatar
  has_many :emails, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :websites, :dependent => :destroy

  has_many :taggings, as: :asset
  has_many :tags, through: :taggings

  has_many :tasks, :as => :asset

  has_many :reportings, :as => :asset, :order => 'created_at DESC'
  has_many :reports, through: :reportings, source: :report, source_type: :report

  has_many :favorite_contacts


  accepts_nested_attributes_for :emails, :reject_if => proc { |attributes| attributes[:address].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes[:national_number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :reject_if => proc { |attributes| attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :websites, :reject_if => :all_blank, :allow_destroy => true

  mount_uploader :avatar, AvatarUploader

  scope :with_name_like, lambda { |pattern| where('name LIKE ? OR first_name LIKE ?', "%#{pattern}%", "%#{pattern}%").order(:name) }
  scope :with_first_name_and_last_name, lambda { |pattern,fn,ln| where('first_name LIKE ? AND name LIKE ? OR name LIKE ?', "%#{fn}%", "%#{ln}%","%#{pattern}%").order(:name)}

  def city
    @city ||= addresses.first.city
  end

  def country
    @country ||= addresses.first.country
  end


  def reject_if_all_blank_except_country
    attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank?
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).assets
  end


  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.search(search)
    if search.present?
      a = search.split
      if a.size > 1
        Contact.with_first_name_and_last_name(search,a.shift,a.join(' '))
      else
        Contact.with_name_like(search)
      end
    else
      Contact.order(:name)
    end
  end


  def favorite?(user)
    @favorite ||= self.favorite_contacts.where(user_id: user.id).any?
  end
end
