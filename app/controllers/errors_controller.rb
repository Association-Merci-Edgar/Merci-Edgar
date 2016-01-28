class ErrorsController < ApplicationController
  skip_filter :authenticate_user!
  skip_filter :check_user
  skip_filter :check_membership
  skip_filter :check_plan

  def routing
    render_404
  end

  private
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404: #{exception.message}"
    end

    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
