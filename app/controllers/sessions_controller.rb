class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    
    if request.subdomain.blank?
      account = resource.accounts.first
    else
      if resource.accounts.exclude?(Account.find_by_domain(request.subdomain))
        raise ActionController::RoutingError.new('User Not Found')
      end
    end
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end