# sample :
# class Article < ActiveRecord::Base
#  attr_localized :price
# end

class String
  def to_delocalized_decimal
    delimiter = I18n::t('number.format.delimiter')
    separator = I18n::t('number.format.separator')
    self.gsub(/[#{delimiter}#{separator}]/, delimiter => '', separator => '.')
  end
end

class ActiveRecord::Base
  def self.attr_localized(*fields)
    fields.each do |field|
      define_method("#{field}=") do |value|
        self[field] = value.is_a?(String) ? value.to_delocalized_decimal : value
      end
    end
  end
end