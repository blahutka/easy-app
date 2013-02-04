class Customer::DashboardController < Customer::BaseController
  defaults :resource_class => ServiceOrder, :collection_name => 'service_orders', :instance_name => 'service_order'
  respond_to :html, :js

  def index
    @service_request = ServiceRequest.find_by_session_id(service_request_id)
    index!{}
  end

  protected

  def collection
    @service_orders ||= current_account.service_orders.
        search(filters_for(:service_orders)).
        includes(:service_request => [:product_brand]).
        paginate(per_page: 10, page: params[:page] || 1)
  end

end