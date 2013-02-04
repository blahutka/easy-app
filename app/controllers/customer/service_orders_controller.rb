# encoding: utf-8
class Customer::ServiceOrdersController < Customer::BaseController
  respond_to :html, :js

  def create
    create! do |success|
      success.html { redirect_to(user_root_path, :notice => 'Požadavek byl odeslán, budete kontaktován servisem.')}
    end
  end

  def update
    #binding.pry
    update! do |success, failure|
      failure.html { render 'edit' }
      success.html { redirect_to(user_root_path) }
    end
  end

  protected

  def collection
    @service_orders ||= end_of_association_chain.paginate(per_page: 10, page: params[:page].presence || 1)
  end

  def build_resource
    service_request = ServiceRequest.find_by_session_id(service_request_id) || ServiceRequest.new(params[:service_request])
    @service_order = begin_of_association_chain.service_orders.build
    @service_order.service_request = service_request
    service_request.session_id = nil
    service_request.save! unless service_request.new_record?
    @service_order
  end
end