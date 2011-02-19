class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @events = Event.all
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
    @event = Event.find(params[:id], :include=>:event_dates)
    render :layout => "grid"
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.creators.exists?(current_user)
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
