class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :site_layout

  before_filter :setup_for_iphone
  helper_method :is_iphone?
  
  def setup_for_iphone
    if is_iphone? && !request.xhr?  
      # request.formats.unshift :html
      # request.formats.unshift :iphone
      session[:rotation] ||= :time_on_side
      logger.debug "iphone formats: #{request.formats.inspect}"
      
      session[:iphone_view] = true
    end  
  end
  
  def is_iphone?
    request.user_agent.to_s =~ /iphone|ipod/i
  end

  def site_layout
    if is_iphone?      
      "iphone"
    else
      "application"
    end
  end
end
