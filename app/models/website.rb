class Website < ActiveRecord::Base
  belongs_to :contact_datum
  attr_accessible :kind, :url
  validates_format_of :url, :allow_blank => true, :with => /(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  before_save :add_url_protocol, :unless => "url.blank?"
  def add_url_protocol
    u = URI.parse(self.url)
    if (!u.scheme)
      self.url = 'http://' + self.url
    end
  end
end
