require 'spec_helper'

describe User do
  it "can invite a user if it is the account manager"
  it "can't invite a user unless it is the account manager"  

  describe "have a valid factory" do
    it { expect(FactoryGirl.build(:user)).to be_valid }
  end
end
