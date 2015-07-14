require 'rails_helper'

describe Festival do

  it { expect(FactoryGirl.build(:festival)).to be_valid }

  describe :fine_model do
    let(:festival) { Festival.new }
    it { expect(festival.fine_model).to eq(festival) }
  end

end
