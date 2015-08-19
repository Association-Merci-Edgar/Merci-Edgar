class ContactsExportsController < AppController
  def new
    ExportContacts.perform_async(current_account.id, current_user.id)
    flash[:notice] = I18n.t('notices.contacts_export.initiated')
    redirect_to contacts_path
  end
end
