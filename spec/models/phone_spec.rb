# == Schema Information
#
# Table name: phones
#
#  id               :integer          not null, primary key
#  number           :string(255)
#  kind             :string(255)
#  contact_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Phone do
  it 'should accept valid phone numbers' do
    Phone.new(:number => "06 61 74 69 69").should be_valid
    Phone.new(:number => "www.merciedgar.com").should be_valid
  end

  it 'should reject invalid phones' do
    Phone.new(:number => "toto http://www.titi.com").should_not be_valid
    Phone.new(:number => "ftp://www.merciedgar.com").should_not be_valid
    Phone.new(:number => "http://www").should_not be_valid
  end

  it 'should be formatted with http protocol' do
    p = Phone.create(:number => "www.merciedgar.com")
    p.number.should == "http://www.merciedgar.com"
  end
end
