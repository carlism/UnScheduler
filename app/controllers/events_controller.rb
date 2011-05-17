class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @events = Rails.cache.fetch("events", :expires_in => 6.hours) do
      Event.all :include => [:event_dates], :order => 'event_dates.event_date desc'      
    end    
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
      Rails.cache.delete("events")
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
      Rails.cache.delete("events")
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
    
    @event_date = select_today_or_first(@event)
    if @event_date
      redirect_to(event_event_date_url(@event, @event_date))
    else
      redirect_to(new_event_event_date_url(@event))
    end
  end
  
  def select_today_or_first(event)
    event.event_dates.select { |d|
      d.event_date == Date.today
    }.first || event.event_dates.first
    # considered the following:
    # t = EventDate.arel_table
    # EventDate.where(t[:event_date].gteq(Date.today).and(t[:event_id].eq(1))).order(:event_date)
    #   .union(EventDate.where(t[:event_date].lt(Date.today).and(t[:event_id].eq(1))).order(:event_date))
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.creator?(current_user)
      if @event.destroy
        Rails.cache.delete("events")
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
