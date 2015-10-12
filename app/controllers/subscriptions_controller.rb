class SubscriptionsController < ApplicationController
  skip_before_filter :check_membership, :check_plan
  def new
  end
  
  def edit
    
  end

  def create
    token = params[:stripeToken]
    amount = (params[:amount].to_f * 100).to_i
    team = params[:team].to_bool
    plan = team ? "GOLD" : "SOLO"
    begin
      charge = Stripe::Charge.create(
        :amount => amount, # amount in cents
        :currency => "eur",
        :source => token,
        :description => "Adhesion #{plan}"
      )
      
      account = current_account
      account.last_subscription_at = Date.current
      account.team = team
      if account.save
        render :create
      else
        redirect_to new_subscription_path, notice: "Une erreur est survenue mais votre carte a bien été débitée"
      end
    rescue Stripe::CardError => e
      puts "EXCEPTION DURING CHARGING...#{e}"
      # The card has been declined
      redirect_to new_subscription_path, notice: e.to_s
    end
  end
end