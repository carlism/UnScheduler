class DomainConstraints
  def matches?(request)
    Event.find_by_host(request.host)
  end
end