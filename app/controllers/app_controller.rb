class AppController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user
  before_filter :check_membership
  before_filter :check_plan
  
  def check_user
    if user_signed_in? && (!current_user.has_role? :admin)
      if ! current_user.authorized_for_domain?(request.subdomain)
        #raise  ActionController::RoutingError.new('Not Found')
        sign_out current_user
        redirect_to root_path, notice: "Vous n'avez pas le droit d'accéder à cette page"
      end
    end
  end
  
  def check_membership
    if (!current_user.has_role? :admin)
      if current_account.subscription_up_to_date? 
        flash[:notice] = t("notices.subscriptions.need_to_subscribe_soon_html", link: new_subscription_path, end_subscription: l(current_account.subscription_lasts_at)).html_safe if current_account.subscription_ended_in_less_than_one_month?
      else  
        if current_account.trial_period_ended?
          notice = t("notices.subscriptions.trial_period_ended") 
        else
          notice = t("notices.subscriptions.not_up_to_date") 
        end
        redirect_to new_subscription_path, notice: notice
      end 
    end
  end
  
  def check_plan
    if (!current_user.has_role? :admin) && !current_account.team? && current_account.member?(current_user)
      redirect_to edit_subscription_path, notice: t('notices.subscriptions.single_user_access', account_name: current_account.name, manager_name: current_account.manager.name)
    end
  end
end
