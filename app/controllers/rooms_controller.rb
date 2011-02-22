class RoomsController < ApplicationController
  def new
    @event_date = EventDate.find params[:event_date_id]
    @room = @event_date.rooms.build
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to(event_event_date_url(@room.event_date.event_id, @room.event_date_id), :notice => 'Room was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
    @event_date = @room.event_date
  end

  def destroy
  end

end
