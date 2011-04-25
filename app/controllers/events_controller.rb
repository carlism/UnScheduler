class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @events = Event.all :include => [:event_dates], :order => 'event_dates.event_date desc'
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    @creator = Role.new(:role_type => "creator")
    current_user.roles << @creator

    if @event.save
      @event.roles << @creator
      redirect_to(events_url, :notice => 'Event was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    @new_admin = @event.roles.build(:role_type=>'admin')
    @new_domain = @event.domains.build
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to(event_path, :notice => 'Event was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
    if params[:id]
      @event = Event.find(params[:id], :include=>:event_dates)
    else
      @event = Event.find_by_host(request.host)
    end
    @event_date = @event.event_dates.first
    if @event_date
      redirect_to(event_event_date_url(@event, @event_date))
    else
      redirect_to(new_event_event_date_url(@event))
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.creator?(current_user)
      if @event.destroy
        flash[:notice] = "Successfully deleted event."
      else
        flash[:alert] = "Failed to delete event."
      end
    else
      flash[:alert] = "You need to be the creator of an event to delete it."              
    end

    redirect_to(events_url)
  end

end
