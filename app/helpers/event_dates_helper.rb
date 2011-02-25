module EventDatesHelper
  def rotation_rows
    if rotation == :time_on_top
      "room_rows"
    else
      "time_rows"
    end
  end

  def rotation
    session[:rotation] ||= :time_on_top
  end
end
