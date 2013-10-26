class PresentationsController < ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
    @event_date = @presentation.time_slot.event_date
    @event = @event_date.event
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
    @presentation.save
    @event_date = @presentation.time_slot.event_date
    redirect_to(event_event_date_url(@event_date.event, @event_date), :notice => 'Presentation was successfully created.')
  rescue ActiveRecord::RecordNotUnique => e
    @time_slot = TimeSlot.find(params[:presentation][:time_slot_id])
    @event_date = @time_slot.event_date
    redirect_to(event_event_date_url(@event_date.event, @event_date), :error => 'Presentation failed time slot/room taken.')
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
  
  def destroy
    @presentation = Presentation.find(params[:id])
    @event_date = @presentation.time_slot.event_date
    if @presentation.destroy
      flash[:notice] = "Successfully deleted presentation."
    else
      flash[:alert] = "Failed to delete presentation."
    end    
    redirect_to(event_event_date_url(@event_date.event, @event_date))
  end
end
