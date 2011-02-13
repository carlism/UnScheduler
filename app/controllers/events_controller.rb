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
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to @event
    else
      render :action => 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])    
  end
  
  def show
    @event = Event.find(params[:id])    
    render :layout => "grid"
  end
end
