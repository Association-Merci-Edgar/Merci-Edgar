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
    @asset = Venue.find(params[:venue_id]) if params[:venue_id]
    @asset = Person.find(params[:person_id]) if params[:person_id]
    @users = Account.find(Account.current_id).users
  end

  def update
    @task = Task.find(params[:id])
    @asset = @task.asset
    if @task.update_attributes(params[:task])
      link = @asset.present? ? send("#{@asset.class.name.underscore}_path",@asset) : tasks_path
      render :js => "window.location = '#{link}?tab=tasks'"
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
      link = @asset.present? ? send("#{@asset.class.name.underscore}_path",@asset) : tasks_path
      render :js => "window.location = '#{link}?tab=tasks'"
    else
      respond_to do |format|
        format.js
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
