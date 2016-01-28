class UsersController < ApplicationController
  skip_filter :check_user
  skip_filter :check_membership
  skip_filter :check_plan

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    render layout: "simple"
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user.label_name = current_account.name
  end
  
  def update
    @user = User.find(params[:id])
    if current_user != @user
      authorize! :update, @user, :message => 'Not authorized as an administrator.'
      if @user.update_attributes(params[:user], :as => :admin)
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    else
      if @user.update_attributes(params[:user])
        redirect_to users_path, :notice => "User updated."
      else
        render :edit
      end
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def invite
    authorize! :invite, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    @user.send_confirmation_instructions
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{@user.email}."
  end

  def bulk_invite
    authorize! :bulk_invite, @user, :message => 'Not authorized as an administrator.'
    users = User.where(:confirmation_token => nil).order(:created_at).limit(params[:quantity])
    count = users.count
    users.each do |user|
      user.send_confirmation_instructions
    end
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{count} users."
  end

end
