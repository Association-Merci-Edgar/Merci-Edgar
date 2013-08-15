# == Schema Information
#
# Table name: websites
#
#  id               :integer          not null, primary key
#  url              :string(255)
#  kind             :string(255)
#  contact_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Website do
  it 'should accept valid url' do
    Website.new(:url => "http://www.merciedgar.com").should be_valid
    Website.new(:url => "www.merciedgar.com").should be_valid
  end

  it 'should reject invalid urls' do
    Website.new(:url => "toto http://www.titi.com").should_not be_valid
    Website.new(:url => "ftp://www.merciedgar.com").should_not be_valid
    Website.new(:url => "http://www").should_not be_valid
  end

  it 'should be formatted with http protocol' do
    w = Website.create(:url => "www.merciedgar.com")
    w.url.should == "http://www.merciedgar.com"
  end
end
