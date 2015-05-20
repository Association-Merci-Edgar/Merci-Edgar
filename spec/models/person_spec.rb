require 'rails_helper'

describe Person do

  it { expect(FactoryGirl.build(:person)).to be_valid }

end
