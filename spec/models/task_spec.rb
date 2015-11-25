require "rails_helper"

describe Task do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:task)).to be_valid }
  end

  describe "friendly_date" do
    let(:date) { DateTime.new(2015, 11, 13, 21, 56) }

    before(:each) do
      ActiveSupport::TimeZone.stubs(:now).returns(date)
      Date.stubs(:current).returns(date)
      DateTime.stubs(:now).returns(date)
    end

    context "not completed tasks" do
      let(:task) { FactoryGirl.build(:task, due_at: date + 4.days ) }
      it { expect(task.friendly_date).to eq(["black", "En retard // 17 nov. 22:56"]) }
    end
  end
end

