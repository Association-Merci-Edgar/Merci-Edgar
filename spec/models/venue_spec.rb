# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

require 'spec_helper'

describe Venue do
  it 'should require a name' do
    should_not be_valid
  end

  it 'should reject a venue without address' do
    v = Venue.new(:name => "My Venue", :contact_datum_attributes => {})
    v.should_not be_valid
  end

  it 'should require a city and a country' do
    v = Venue.new(:name => "My Venue")
    v.should_not be_valid
  end

  it 'should accept a venue with a name, a city and a country' do
    v = FactoryGirl.build(:venue)
    v.should be_valid
  end

  it 'should reject a venue without a city' do
    v = FactoryGirl.build(:venue)
    v.addresses.first.city = nil
    v.should_not be_valid
  end

  it 'should reject a venue without a country' do
    v = FactoryGirl.build(:venue)
    v.addresses.first.country = nil
    v.should_not be_valid
  end

  it 'should reject a venue with same name in same city' do
    v = FactoryGirl.create(:venue)
    v2 = FactoryGirl.build(:venue)
    v2.should_not be_valid
  end
end
