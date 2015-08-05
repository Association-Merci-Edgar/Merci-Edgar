require "rails_helper"

describe ShowBuyer do

  describe "Have validations and a valid factory" do
    it { expect(FactoryGirl.build(:show_buyer)).to be_valid }
  end
end
