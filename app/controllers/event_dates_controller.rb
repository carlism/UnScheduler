class EventDatesController < ApplicationController
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
    @grid = if @event.admin?(current_user)    
      @event_date.build_grid
    else
      Rails.cache.fetch("presentation_grid_#{@event.id}", :expires_in => 3.minutes) do
        @event_date.build_grid
      end
    end
  end
  
  def rotate
    if session[:rotation] == :time_on_top
      session[:rotation] = :time_on_side
    else
      session[:rotation] = :time_on_top
    end
    @event_date = EventDate.find(params[:id])
    redirect_to(event_event_date_url(@event_date.event, @event_date))
  end
  
  
  def update
    @event_date = EventDate.find(params[:id])
    @event_date.rooms.each do |room|
      room.position = params[:room].index(room.id.to_s)
      room.save
    end
  end
  
  def swap
    @event = Event.find(params[:event_id])
    @from = params[:from].split '_'
    @to = params[:to].split '_'
    @p = {}
    @p[:from] = Presentation.find_by_time_slot_id_and_room_id(@from[0], @from[1])
    @p[:to] = Presentation.find_by_time_slot_id_and_room_id(@to[0], @to[1])
    ActiveRecord::Base.transaction do
      if @p[:to]
        @p[:to].time_slot_id, @p[:to].room_id = nil, nil
        @p[:to].save          
      end
      if @p[:from]
        @p[:from].time_slot_id, @p[:from].room_id = @to[0], @to[1]
        @p[:from].save
      end
      if @p[:to]
        @p[:to].time_slot_id, @p[:to].room_id = @from[0], @from[1]
        @p[:to].save    
      end
    end
  end
end
