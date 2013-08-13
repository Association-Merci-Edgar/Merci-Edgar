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
