require "rails_helper"

describe Task do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:task)).to be_valid }
  end

  describe "friendly_date" do
    let(:date) { DateTime.new(2015, 11, 13, 13, 56) }

    before(:each) do
      ActiveSupport::TimeZone.stubs(:now).returns(date)
      Date.stubs(:current).returns(date)
      DateTime.stubs(:now).returns(date)
      Time.stubs(:now).returns(date)
    end

    context "not completed tasks" do
      context "En retard" do
        let(:task) { FactoryGirl.build(:task, completed_at: nil,  due_at: (date - 2.hours)) }
        it { expect(task.friendly_date).to eq(["black", "En retard // 13 nov. 12:56"]) }
      end

      context "Aujourd'hui" do
        let(:task) { FactoryGirl.build(:task, completed_at: nil, due_at: (date + 4.hours) ) }
        it { expect(task.friendly_date).to eq(["red", "Aujourd'hui"]) }
      end

      context "Demain" do
        let(:task) { FactoryGirl.build(:task, completed_at: nil, due_at: (date + 1.day + 4.hours) ) }
        it { expect(task.friendly_date).to eq(["blue", "Demain"]) }
      end

      context "La semaine prochaine" do
        let(:task) { FactoryGirl.build(:task, completed_at: nil, due_at: (date + 4.day + 4.hours) ) }
        it { expect(task.friendly_date).to eq(["gray", "La semaine prochaine"]) }
      end

    end

    context "completed tasks" do
      context "without due date" do
        let(:task) { FactoryGirl.build(:task, completed_at: date - 3.hours, due_at: date - 2.hours) }
        it { expect(task.friendly_date).to eq(["green", "13 nov. 11:56"]) }
      end
    end
  end
end

