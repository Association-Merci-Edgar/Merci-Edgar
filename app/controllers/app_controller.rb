class AppController < ApplicationController
  before_filter :authenticate_user!
end