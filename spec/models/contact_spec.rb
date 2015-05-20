require 'rails_helper'

describe Contact do

  it { expect(FactoryGirl.build(:contact)).to be_valid }

end
