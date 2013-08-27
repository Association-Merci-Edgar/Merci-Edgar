class ContactsController < ApplicationController
  def index
    @contacts = Contact.order(:name).page params[:page]
  end
end
