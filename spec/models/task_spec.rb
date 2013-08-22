# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  priority     :integer
#  category     :string(255)
#  bucket       :string(255)
#  due_at       :datetime
#  completed_at :datetime
#  asset_id     :integer
#  asset_type   :string(255)
#  assigned_to  :integer
#  completed_by :integer
#  account_id   :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Task do
  it "should create a new task instance given valid attributes" do
    task = FactoryGirl.create(:task)
    task.should be_valid
    task.errors.should be_empty
  end
  it 'should require a user' do
    task = FactoryGirl.build(:task, :user => nil)
    task.should_not be_valid
    task.errors[:user].should_not be_empty
  end
  it 'should require a name' do
    task = FactoryGirl.build(:task, :name => "")
    task.should_not be_valid
    task.errors[:name].should_not be_empty
  end

  it 'should be completed by a user' do
    task = FactoryGirl.create(:task)
    user = FactoryGirl.create(:confirmed_user)
    task.complete(user)
    task.completor.should == user
  end

  it 'should be assigned to a user' do
    task = FactoryGirl.create(:task)
    user = FactoryGirl.create(:confirmed_user)
    task.assign_to(user)
    task.assignee.should == user
    Task.tracked_by(user).should include(task)
  end
end
