class ContactsExportsController < ApplicationController
  skip_filter :check_user
  skip_filter :check_membership
  skip_filter :check_plan

  def new
    ExportContacts.perform_async(current_account.id, current_user.id)
    redirect_to edit_account_path, notice: I18n.t('notices.contacts_export.initiated')
  end
end
