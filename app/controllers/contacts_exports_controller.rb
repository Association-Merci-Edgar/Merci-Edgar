class ContactsExportsController < AppController
  def new
    send_file(current_account.export_contacts)
  end
end
