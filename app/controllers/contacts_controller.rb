class ContactsController < AppController
  def index
    if params[:tag]
      @filtered_by = "(#{params[:tag]})"
      @contacts = Kaminari.paginate_array(Contact.tagged_with(params[:tag])).page params[:page]
    else
      @contacts = Contact.search(params[:search]).order(:name).page params[:page]
    end
  end
end
