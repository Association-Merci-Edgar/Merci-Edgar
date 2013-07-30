class Account < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :venues
  attr_accessible :domain, :name
  validates_presence_of :name
  validates_uniqueness_of :domain
  validates_exclusion_of :domain, :in => ['www','blog','mail','ftp']
  before_create :ensure_domain_uniqueness

  def ensure_domain_uniqueness
    if self.domain.blank? || Account.find_by_domain(self.domain).count > 0
      domain_part = self.name.downcase
      new_domain = domain_part.dup
      num = 2
      while (Account.find_by_domain(new_domain).present?)
        new_domain = "#{domain_part}#{num}"
      end
      self.domain = new_domain
    end
  end

  def self.current_id=(id)
    Thread.current[:account_id] = id
  end

  def self.current_id
    Thread.current[:account_id]
  end
end
