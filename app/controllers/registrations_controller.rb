class RegistrationsController < Devise::RegistrationsController
  layout "simple"

  def new
    resource = build_resource(params[:user])
    respond_with resource
  end
  
  def create
    if 1 == 2
      create_confirmation_needed
    else
      @user = User.new(params[:user])
      if @user.valid?
        @user.confirm!
        abilitation = @user.abilitations.build
        abilitation.build_account(name: @user.label_name)
        abilitation.kind = "manager"
        @user.save!
        sign_in(@user)
        redirect_to "#{request.protocol}#{abilitation.account.domain}.#{request.domain}:#{request.port}#{new_user_session_path}"        
      else
        render "new"
      end
    end
  end
  # override #create to respond to AJAX with a partial
  def create_with_confirmation
    build_resource(params[:user])

    if resource.save
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      render :action => :new, :layout => !request.xhr?
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    # the page prelaunch visitors will see after they request an invitation
    # unless Ajax is used to return a partial
    '/thankyou.html'
  end

  def after_sign_up_path_for(resource)
    # the page new users will see after sign up (after launch, when no invitation is needed)
    redirect_to root_path
  end

end
