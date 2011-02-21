module EventDatesHelper
  def column_headings
    if rotation == :time_on_top
      "time_column_header"
    else
      "room_column_header"
    end
  end

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
