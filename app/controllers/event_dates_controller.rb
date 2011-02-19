class EventDatesController < ApplicationController
  layout "grid"

  def destroy
    @event_date = EventDate.find(params[:id])
    @event = @event_date.event
    @event_date.destroy
    redirect_to event_url(@event)
  end

  def create
    @event_date            = EventDate.new(params[:event_date])
    @event_date.event_id   = params[:event_id]
    if @event_date.save
      redirect_to(event_event_date_url(@event_date.event, @event_date), :notice => 'Event date was successfully created.')
    else
      render :show
    end
  end

  def new
    @event = Event.find(params[:event_id])
    render :show
  end

  def show
    @event_date = EventDate.find(params[:id])
    @event = @event_date.event
  end
end
