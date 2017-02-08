require 'rails_helper'

describe TagHelper do
  describe "#clean" do
    it "do nothing with 'toto'" do
      expect(TagHelper.clean("toto")).to eq("toto")
    end

    it "downcase TOTO" do
      expect(TagHelper.clean("TOTO")).to eq("toto")
    end

    it "remove space in '  toto  '" do
      expect(TagHelper.clean("  toto  ")).to eq("toto")
    end
  end
end
