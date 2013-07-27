class Account < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :domain, :name
  validates_presence_of :name
  validates_uniqueness_of :domain
  before_create :ensure_domain_uniqueness

  def ensure_domain_uniqueness
    if self.domain.blank? || Account.find_by_domain(self.domain).count > 0
      domain_part = self.name
      new_domain = domain_part.dup
      num = 2
      while (Account.find_by_domain(new_domain).present?)
        new_domain = "#{domain_part}#{num}"
      end
      self.domain = new_domain
    end
  end
end
