class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_current_tenant
  after_filter :reset_tenant

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def current_account
    Account.find(Account.current_id)
  end

  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  private
  def set_current_tenant
    account = Account.find_by_domain(request.subdomain)
    Account.current_id = account.id if account
  end

  private
  def reset_tenant
    Account.current_id = nil
  end

end
