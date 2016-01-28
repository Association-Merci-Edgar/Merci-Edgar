
class ExportContacts
  include SidekiqStatus::Worker

  def perform(account_id, user_id)
        puts "- dans perform" * 50
    Account.current_id = account_id
    account = Account.find(account_id)
    user = User.find(user_id)
        puts "- 0" * 50
    UserMailer.export_contacts(user, store(account.export_contacts)).deliver
        puts "- 9" * 50
  end
  
  def store(filename)
    File.open(filename) do |f|
      uploader = ExportUploader.new
      uploader.store_dir = "uploads/export/#{SecureRandom.hex(20)}"
      uploader.store!(f)
      uploader.url
    end
  end
end
