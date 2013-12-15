class AbilitationsController < AppController
  
  def create
    user = User.find_by_email(params[:abilitation][:user_attributes][:email])
    if user
      params[:abilitation].delete(:user_attributes)
      params[:abilitation][:user_id] = user.id
    end
    
    @abilitation = current_account.abilitations.build(params[:abilitation])
    if @abilitation.save
      if user
        #TODO user.send_abilitation_notification
      else
        # send_confirmation_instructions_with_abilitation
        @abilitation.user.send_abilitation_instructions(current_account, current_user)
      end
      redirect_to edit_account_path
    end
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
