require "rails_helper"

describe UserMailer do
  describe "welcome email" do
    let(:user) { FactoryGirl.create(:user) }
    let(:email) { UserMailer.welcome_email(user) }

    it { expect(email.to).to eq([user.email]) }
    it { expect(email.body.encoded).to match('Welcome') }
    it { expect(email.subject).to match('Request Received') }
  end

  describe "subscription receipt email" do
    let(:account) { FactoryGirl.create(:account) }
    let(:manager) { FactoryGirl.create(:user, manager: true, account: account) }
    let(:email) { UserMailer.subscription_receipt_email(account, manager, 20) }
    it { expect(email.to).to eq([manager.email]) }
    it { expect(email.body.encoded). to match('20') }
    it { expect(email.subject).to match('Adhesion validee') }
  end
end
