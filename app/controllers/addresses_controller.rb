class AddressesController < AppController
  def update
    address = Address.where(id: params[:id], account_id: Account.current_id).first
    if address
      address.latitude = params[:latitude]
      address.longitude = params[:longitude]
      address.geocoded_precisely = true
      if address.save
        render json: {lat:address.latitude, lng: address.longitude, yupee: "ok"}
      else
        render text: "fuck"
      end
    else
      render text: "fuck"
    end
  end
end