require 'rails_helper'

describe Account do

  it "have a valid factory" do
    expect(FactoryGirl.build(:account)).to be_valid
  end

  describe :destroy_test_contacts do
    it "keeps contacts that not from an imported test" do
      account = FactoryGirl.create(:account, test_imported_at: nil)
      contact = FactoryGirl.create(:contact, imported_at: nil, account: account)
      person = FactoryGirl.create(:person, account_id: account.id, contact: contact)
      Account.current_id = account
      account.destroy_test_contacts
      expect(account.reload.contacts.count).to eq(1)
    end

    it "remove contacts from an imported test" do
      date = DateTime.new(2014,3,23, 10, 22)
      account = FactoryGirl.create(:account, test_imported_at: date)
      contact = FactoryGirl.create(:contact, imported_at: date, account: account)
      person = FactoryGirl.create(:person, account_id: account.id, contact: contact)
      Account.current_id = account
      account.destroy_test_contacts
      expect(account.reload.contacts.count).to eq(0)
    end

    it "keeps contacts that was imported before last test" do
      date = DateTime.new(2014,3,23, 10, 22)
      later_date = DateTime.new(2014,3,23, 14, 52)
      account = FactoryGirl.create(:account, test_imported_at: later_date)

      contact = FactoryGirl.create(:contact, imported_at: date, account: account)
      contact_to_remove = FactoryGirl.create(:contact, imported_at: later_date, account: account)

      person = FactoryGirl.create(:person, account_id: account.id, contact: contact)
      other_person = FactoryGirl.create(:person, account_id: account.id, contact: contact_to_remove)

      Account.current_id = account

      account.destroy_test_contacts
      expect(account.reload.contacts.count).to eq(1)
      expect(account.reload.contacts).to eq([contact])
    end
  end

  describe :export_contacts do
    it "have something in exported file" do
      DateTime.stubs(:now).returns(DateTime.new(2010, 12, 30))
      account = FactoryGirl.build(:account)
      expect(File.stat(account.export_contacts).size).to satisfy{|v| v > 0}
    end

    it "return filename that was generated" do
      DateTime.stubs(:now).returns(DateTime.new(2010, 12, 30))
      account = FactoryGirl.build(:account)
      expect(account.export_contacts).to eq(account.export_filename)
    end
  end

  describe :export_filename do
    it "build name with date and account domain" do
      DateTime.stubs(:now).returns(DateTime.new(2010, 12, 30))
      account = FactoryGirl.build(:account)
      expect(account.export_filename).to eq(File.join(Dir.tmpdir, "#{account.domain}-30122010.zip"))
    end
  end

  describe :manager? do
    it "return false without habilitation" do
      account = FactoryGirl.create(:account)
      user = FactoryGirl.create(:user)
      expect(account.manager?(user)).to be_falsy
    end
  end

  describe :trial_period_ended? do
    it "return false when account created more than one month ago" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY - 10.days)
      date = Date.current - 32.days
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_ended?).to be_falsy
    end

    it "return false when account created less than one month ago but before the opening subscription day" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY - 10.days)
      date = Date.current - 15.days
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_ended?).to be_falsy
    end

    it "return true when account created more than one month ago and we are after the subscription day" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 10.days)
      date = Date.current - 32.days
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_ended?).to be_truthy
    end

    it "return false when account created less than one month ago and we are after the subscription day" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 10.days)
      date = Date.current - 15.days
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_ended?).to be_falsy
    end

    it "return true when account already subscribed" do
      account = FactoryGirl.create(:account, last_subscription_at: Date.current - 1.day)
      expect(account.trial_period_ended?).to be_truthy
    end
  end

  describe :in_trial_period? do
    it "return true when last_subscription_at is nil and we are before opening_subscription_day" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY - 10.days)
      date = Date.current - 2.months
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.in_trial_period?).to be_truthy
    end

    it "return false when account is not subscribed and created more than one month before" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 10.days)
      date = Date.current - 2.months
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.in_trial_period?).to be_falsy
    end

    it "return true when account is not subscribed and created less than one month ago" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 10.days)
      date = Date.current - 2.weeks
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.in_trial_period?).to be_truthy
    end
  end

  describe :trial_period_lasts_at do
    it "returns Opening_subscription_day when account created more than one month ago" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY - 10.days)
      date = Date.current - 2.months
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_lasts_at).to eq(Account::OPENING_SUBSCRIPTION_DAY)
    end

    it "returns date + 1.month when account created 2 weeks ago" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY - 10.days)
      date = Date.current - 2.weeks
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_lasts_at).to eq(date + 1.month)
    end

    it "returns date + 1.month when today is after opening_subscription_day" do
      Date.stubs(:current).returns(Account::OPENING_SUBSCRIPTION_DAY + 10.days)
      date = Date.current - 2.weeks
      account = FactoryGirl.create(:account, last_subscription_at: nil, created_at: date)
      expect(account.trial_period_lasts_at).to eq(date + 1.month)
    end
  end


  describe :subscription_up_to_date? do
    it "returns false with a last_subscription_at more than one year ago" do
      date = Date.current.to_date - 1.year - 1.day
      account = FactoryGirl.create(:account, created_at: date - 1.month, last_subscription_at: date)
      expect(account.subscription_up_to_date?).to be_falsy
    end

    it "returns true with a last_subscription_at less than one year ago" do
      date = Date.current - 100.days
      account = FactoryGirl.create(:account, last_subscription_at: date)
      expect(account.subscription_up_to_date?).to be_truthy
    end
  end

  describe :subscription_lasts_at do
    it "returns last_subscription_at + 1.year" do
      date = Date.current - 100.days
      account = FactoryGirl.create(:account, last_subscription_at: date)
      expect(account.subscription_lasts_at).to eq(account.last_subscription_at + 1.year)
    end
  end

  describe :subscription_ended_in_less_than_one_month? do
    it "returns true when subscription lasts in less than one month" do
      account = FactoryGirl.create(:account, :with_account_subscription_lasts_in_less_than_one_month)
      expect(account.subscription_ended_in_less_than_one_month?).to be_truthy
    end
  end

  describe :subscription_ended_in_less_than_one_week? do
    it "return true when subscription lasts soon" do
      account = FactoryGirl.create(:account, :with_account_subscription_lasts_soon)
      expect(account.subscription_ended_in_less_than_one_week?).to be_truthy
    end
  end


end
__END__
describe "#trial_period_ended_in_less_than_one_week?" do

  it "return true when trial period ended in less than one week" do
    account = FactoryGirl.create(:account, :with_trial_period_lasts_soon)
    expect(account.trial_period_ended_in_less_than_one_week?).to be_truthy
  end

  it "return false when trial_period_ended_in_more_than_one_week" do
    account = FactoryGirl.create(:account, created_at: Date.current)
    expect(account.trial_period_ended_in_less_than_one_week?).to be_falsy
  end

  it "return false when trial period ended today" do
    account = FactoryGirl.create(:account, :with_trial_period_lasts_today)
    expect(account.trial_period_ended_in_less_than_one_week?).to be_falsy
  end
  end

describe "#ended_soon?" do
  it "return true when trial period ended today" do
    account = FactoryGirl.create(:account, :with_trial_period_lasts_today)
    expect(account.ended_soon?).to be_truthy
  end

  it "return false when trial period ended in more than one week" do
    account = FactoryGirl.create(:account, created_at: Date.current)
    expect(account.ended_soon?).to be_falsy
  end

  it "return true when trial period ended in less than one week" do
    account = FactoryGirl.create(:account, :with_trial_period_lasts_soon)
    expect(account.ended_soon?).to be_truthy
  end
  end

describe "#plan" do
  it "return solo plan when account team is false" do
    account = FactoryGirl.build(:account, team: false)
    expect(account.plan).to eq(I18n.t('account.solo_plan'))
  end

  it "return team plan when account team is true" do
    account = FactoryGirl.build(:account, team: true)
    expect(account.plan).to eq(I18n.t('account.team_plan')) }
  end
  end

describe "#upgrade!" do
  it "upgrades" do
    account = FactoryGirl.build(:account, team: false)
    account.upgrade!
    expect(account.team).to be_truthy
  end
end
end

