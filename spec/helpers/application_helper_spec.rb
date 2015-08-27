require "rails_helper"

describe ApplicationHelper, type: :helper do

  describe "stage_of" do
    context "room without stage info" do
      let(:room) { FactoryGirl.build(:room, depth: nil, width: nil, height: nil) }
      it { expect(stage_of(room)).to eq("Dimension plateau non précisée") }
    end

    context "room without stage info" do
      let(:room) { FactoryGirl.build(:room, depth: nil, width: 10, height: 1) }
      it { expect(stage_of(room)).to eq("Dimension plateau : P 0, L 10.0, H 1.0") }
    end

    context "room with stage info" do
      let(:room) { FactoryGirl.build(:room, depth: 10, width: 20, height: 2) }
      it { expect(stage_of(room)).to eq("Dimension plateau : P 10.0, L 20.0, H 2.0") }
    end
  end

  describe "name_of" do
    context "room without name" do
      let(:room) { FactoryGirl.build(:room, name: nil) }
      it { expect(name_of(room)).to eq("Salle") }
    end

    context "room with name" do
      let(:room) { FactoryGirl.build(:room, name: "Vivaldi") }
      it { expect(name_of(room)).to eq("Salle : Vivaldi") }
    end
  end
end
