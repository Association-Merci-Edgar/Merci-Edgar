require 'spec_helper'

describe ContactDatum do
  it 'should accept valid phone numbers' do
    c = FactoryGirl.build(:contact_datum)
    c.phones.first.should be_valid

    c.phones.first.number = "+33661746969"
    c.phones.first.should be_valid
  end

  it 'should reject invalid phones' do
    Phone.new(:number => "09").should_not be_valid
    Phone.new(:number => "ftp").should_not be_valid
  end

  it 'should be formatted based on country' do
    c = FactoryGirl.create(:contact_datum)
    c.phones.first.formatted_phone.should == "+33 6 61 74 69 69"

    c.phones.first.number = "+33661746969"
    c.save!
    c.phones.first.formatted_phone.should == "+33 6 61 74 69 69"

  end
end

