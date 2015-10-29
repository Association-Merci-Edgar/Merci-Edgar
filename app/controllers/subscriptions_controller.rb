class SubscriptionsController < ApplicationController
  skip_before_filter :check_membership, :check_plan
  def new
  end
  
  def edit
    
  end

  def create
    token = params[:stripeToken]
    amount = params[:amount]
    amount_in_cents = (amount.to_f * 100).to_i
    team = params[:team].to_bool
    plan = team ? "GOLD" : "SOLO"
    begin
      charge = Stripe::Charge.create(
        :amount => amount_in_cents,
        :currency => "eur",
        :source => token,
        :description => "Adhesion #{plan}"
      )
      
      account = current_account
      account.subscribe(team)

      if account.save
        SendSubscriptionReceiptEmailWorker.perform_async(account.id, current_user.id, amount)
        redirect_to edit_account_path, 
          notice: t('notices.subscriptions.done', end_subscription: l(account.subscription_lasts_at))
      else
        redirect_to new_subscription_path, notice: "Une erreur est survenue mais votre carte a bien été débitée"
      end
    rescue Stripe::CardError => e
      # The card has been declined
      redirect_to new_subscription_path, notice: e.to_s
    end
  end
end
