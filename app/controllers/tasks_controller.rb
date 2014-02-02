# encoding: utf-8
class TasksController < ApplicationController
  def new
    #@asset = Venue.find(params[:venue_id]) if params[:venue_id]
    #@asset = Person.find(params[:person_id]) if params[:person_id]
    @asset = Contact.find(params[:contact_id]) if params[:contact_id]
    @task = Task.new
    @users = Account.find(Account.current_id).users
  end

  def edit
    @task = Task.find(params[:id])
    @asset = Contact.find(params[:contact_id]) if params[:contact_id]
    @users = Account.find(Account.current_id).users
  end

  def update
    @task = Task.find(params[:id])
    @asset = @task.asset
    if @task.update_attributes(params[:task])
      if @asset
        @pending_tasks = @task.asset.tasks.pending
        @completed_tasks = @task.asset.tasks.completed
      else
        @redirect = true
      end
    else
      render :edit
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.complete(current_user)
    if @task.save
      # head :no_content
      render "complete"
    end
  end

  def uncomplete
    @task = Task.find(params[:id])
    @task.uncomplete
    if @task.save
      render "uncomplete"
    end
  end

  def create
    @task = Task.new(params[:task])
    @asset = @task.asset
    if @task.save
      if @asset
        @pending_tasks = @task.asset.tasks.pending
        @completed_tasks = @task.asset.tasks.completed
      else
        @redirect = true
      end
      
      render "create"
    else
      respond_to do |format|
        render "errors"
      end
    end
    
  end

  def index
    @tasks = Task.tracked_by(current_user)
    @pending_tasks = @tasks.pending
    respond_to do |format|
      format.html
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.prodid = "MerciEdgar-Calendar"
        @tasks.each do |t|
          calendar.add_event(t.to_ics)
        end
        render :text => calendar.to_ical
      end
    end
  end
end
