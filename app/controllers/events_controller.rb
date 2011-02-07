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
    @events = Event.find(params[:id])    
  end
  
  def show
    @events = Event.find(params[:id])    
  end
end
