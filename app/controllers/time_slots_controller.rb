class TimeSlotsController < ApplicationController
  def new
    @event_date = EventDate.find params[:event_date_id]
    @time_slot = @event_date.time_slots.build
  end

  def create
    @time_slot = TimeSlot.new(params[:time_slot])
    if @time_slot.save
      redirect_to(event_event_date_url(@time_slot.event_date.event_id, @time_slot.event_date_id), :notice => 'Time slot was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @time_slot = TimeSlot.find(params[:id])
    @event_date = @time_slot.event_date
  end

  def destroy
    @time_slot = TimeSlot.find(params[:id])
    @event_date = @time_slot.event_date
    if @time_slot.destroy
      flash[:notice] = "Successfully deleted time slot."
    else
      flash[:alert] = "Failed to delete time slot."
    end
    redirect_to(event_event_date_url(@event_date.event, @event_date))
  end

  def update
    @time_slot = TimeSlot.find(params[:id])
    if @time_slot.update_attributes(params[:time_slot])
      @event_date = @time_slot.event_date
      redirect_to(event_event_date_url(@event_date.event, @event_date), :notice => 'Time slot was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
