class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :site_layout

  before_filter :setup_for_mobile
  helper_method :is_mobile?

  def setup_for_mobile
    if is_mobile? && !request.xhr?
      # request.formats.unshift :html
      # request.formats.unshift :mobile
      session[:rotation] ||= :time_on_side
      logger.debug "mobile formats: #{request.formats.inspect}"

      session[:mobile_view] = true
    end
  end

  def is_mobile?
    request.user_agent.to_s =~ /mobi/i
  end

  def site_layout
    if is_mobile?
      "mobile"
    else
      "application"
    end
  end
end
