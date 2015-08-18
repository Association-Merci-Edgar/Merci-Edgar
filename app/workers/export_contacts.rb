
class ExportContacts
  include SidekiqStatus::Worker

  def perform(account_id, user_id)
    Account.current_id = account_id
    account = Account.find(account_id)
    user = User.find(user_id)
    UserMailer.export_contacts(account, user, account.export_contacts).deliver
  end
end
