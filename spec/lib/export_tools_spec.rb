require "rails_helper"

describe ExportTools do
  describe "build_list" do
    it { expect(ExportTools.build_list(['toto', 'truc'])).to eq('toto, truc') }
  end
end
