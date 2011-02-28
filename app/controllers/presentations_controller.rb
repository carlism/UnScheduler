class PresentationsController < ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
  end

  def edit
    @presentation = Presentation.find(params[:id])
    @event_date = @presentation.time_slot.event_date
  end

  def new
    @presentation = Presentation.new()
    @presentation.time_slot_id = params[:time_slot_id]
    @presentation.room_id = params[:room_id]
    @time_slot = TimeSlot.find(params[:time_slot_id])
    @event_date = @time_slot.event_date
  end

  def create
    @presentation = Presentation.new(params[:presentation])
    if @presentation.save
      @event_date = @presentation.time_slot.event_date
      redirect_to(event_event_date_url(@event_date.event, @event_date), :notice => 'Presentation was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @presentation = Presentation.find(params[:id])
    if @presentation.update_attributes(params[:presentation])
      @event_date = @presentation.time_slot.event_date
      redirect_to(event_event_date_url(@event_date.event, @event_date), :notice => 'Presentation was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
