class DomainConstraints
  SITE_NAMES = ['www.unscheduler.com', 'unscheduler.com', 'unscheduler.dev', 'localhost', 'www.splatcamp.com']
  def matches?(request)
    not SITE_NAMES.include? request.host
  end
end