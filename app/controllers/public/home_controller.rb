class Public::HomeController < Public::BaseController
  def index
     @service_request = ServiceRequest.find_by_session_id(service_request_id) || ServiceRequest.new
     #binding.pry
     #@service_request.session_id = service_request_id
     #@service_requests = ServiceRequest.find_by_session_id(service_request_id)
  end
end