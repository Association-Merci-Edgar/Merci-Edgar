class ContactsController < ApplicationController
  def index
    if params[:tag]
      @contacts = Kaminari.paginate_array(Contact.tagged_with(params[:tag])).page params[:page]
    else
      @contacts = Contact.order(:name).page params[:page]
    end
  end
end
