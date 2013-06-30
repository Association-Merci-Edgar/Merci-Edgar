class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
end
