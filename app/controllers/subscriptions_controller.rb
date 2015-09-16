class SubscriptionsController < ApplicationController
  skip_before_filter :check_membership, :check_plan
  def new
  end
  
  def edit
    
  end
end