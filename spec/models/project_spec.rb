require "rails_helper"

describe Project do
  it "is invalid with name that contains more than 255 characters" do
    expect(FactoryGirl.build(:project, name: "e" * 256)).to be_invalid
  end
end
