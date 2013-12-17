class ConfirmationsController < Devise::PasswordsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user!

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    if successfully_sent?(resource)
      respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      @confirmable.attempt_set_password(params[:user])
      if @confirmable.valid?
        do_confirm
      else
        do_show
        @confirmable.errors.clear #so that we won't render :new
      end
    end

    if !@confirmable.errors.empty?
      render 'devise/confirmations/new'
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    if !@confirmable.errors.empty?
      render 'devise/confirmations/new'
    end
  end

  protected

  def with_unconfirmed_confirmable
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
    self.resource = @confirmable
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    # @confirmable.accounts.destroy_all
    @account = @confirmable.accounts.build unless @confirmable.accounts.any?
    render 'devise/confirmations/show'
  end

  def do_confirm
    @confirmable.confirm!
    account = @confirmable.accounts.first
    # @job_id = SampleImportWorker.perform_async(account.id)
    
    set_flash_message :notice, :confirmed
    logger.debug "before signin and redirect"
    sign_in(@confirmable)
    redirect_to "#{request.protocol}#{@confirmable.accounts.first.domain}.#{request.domain}:#{request.port}#{new_user_session_path}"
    # sign_in_and_redirect(resource_name, @confirmable)
  end

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    new_session_path(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    after_sign_in_path_for(resource)
  end

end
