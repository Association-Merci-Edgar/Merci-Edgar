class SubscriptionsController < ApplicationController
  skip_before_filter :check_membership
  def new
  end
end