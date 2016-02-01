class AnnouncementsController < ApplicationController
  after_filter :set_last_hit_cookie
  def index
    if current_account.in_trial_period?
      if current_account.trial_period_ended_in_less_than_one_week?
        @membership_warning = t('notices.subscriptions.trial_period_lasts_soon_html',
          end_trial_period: l(current_account.trial_period_lasts_at),
          link: new_subscription_path
        ).html_safe
      elsif current_account.subscription_ended_in_less_than_one_month?
        @membership_warning = t("notices.subscriptions.need_to_subscribe_soon_html",
          link: new_subscription_path, 
          end_subscription: l(current_account.subscription_lasts_at)).html_safe 
      end
    elsif current_account.subscription_up_to_date? 
      if current_account.subscription_ended_in_less_than_one_month?
        @membership_warning = t("notices.subscriptions.need_to_subscribe_soon_html",
          link: new_subscription_path, 
          end_subscription: l(current_account.subscription_lasts_at)).html_safe 
      end
    end 
    @announcements = Announcement.where("published_at <= ?", Time.zone.now).limit(10).order("published_at DESC")    
  end
  
  def set_last_hit_cookie
    cookies.permanent.signed[:last_hit] = Time.zone.now.to_i
  end
end
