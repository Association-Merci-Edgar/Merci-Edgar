require "rails_helper"

describe Task do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:task)).to be_valid }
  end

end

