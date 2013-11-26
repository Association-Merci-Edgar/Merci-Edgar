# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  kind       :string(255)
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Email do
  it 'should accept valid email' do
    Email.new(:address => "toto@toto.com").should be_valid
  end

  it 'should reject invalid email' do
    Email.new(:address => "toto").should_not be_valid
    Email.new(:address => "toto@titi").should_not be_valid
  end
end
