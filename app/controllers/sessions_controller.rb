class SessionsController < Devise::SessionsController
  skip_before_filter :check_user, :check_membership, :check_plan

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    if resource.has_role? :admin || resource.authorized_for_domain?(request.subdomain)
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      redirect_to "#{request.protocol}#{resource.accounts.first.domain}.#{request.domain}:#{request.port}#{new_user_session_path}"
    end
  end
end
