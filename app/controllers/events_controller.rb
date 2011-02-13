class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @events = Event.find(:all)
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    @creator = Role.new(:role_type => Role::CREATOR_ROLE)
    current_user.roles << @creator
    if @event.save
      @event.roles << @creator
      flash[:notice] = "Successfully created event."
      redirect_to events_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])    
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(event_path, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])    
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
    redirect_to events_path
  end
end
