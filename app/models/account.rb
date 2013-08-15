# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  domain     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :venues
  attr_accessible :domain, :name
  validates_presence_of :name
  validates_uniqueness_of :domain, :message => "Domain must be unique"
  validates_exclusion_of :domain, :in => ['www','blog','mail','ftp']
  before_validation :ensure_domain_uniqueness, :on => :create

  def ensure_domain_uniqueness
    if self.domain.blank?
      self.domain = self.name.downcase.delete(' ')
    end
    num = 2
    while (Account.find_by_domain(self.domain).present?)
      self.domain = "#{self.domain}#{num}"
      num += 1
    end
  end

  def self.current_id=(id)
    Thread.current[:account_id] = id
  end

  def self.current_id
    Thread.current[:account_id]
  end
end
