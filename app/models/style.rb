class Style < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }
  validates :style, presence: true, uniqueness: true
  
  def self.add_style(style_name)
    s = Style.new()
    s.style = style_name
    s.save
  end
  
  def self.add_styles(styles)
    styles.each { |s| add_style(s) }
  end
  
end