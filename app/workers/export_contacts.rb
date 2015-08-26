
class ExportContacts
  include SidekiqStatus::Worker

  def perform(account_id, user_id)
    Account.current_id = account_id
    account = Account.find(account_id)
    user = User.find(user_id)
    UserMailer.export_contacts(user, store(account.export_contacts)).deliver
  end
  
  def store(filename)
    File.open(filename) do |f|
      uploader = ExportUploader.new
      uploader.store!(f)
      uploader.url
    end
  end
end
