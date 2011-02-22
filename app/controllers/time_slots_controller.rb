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
    @event_date = @room.event_date
  end

  def destroy
  end

end
