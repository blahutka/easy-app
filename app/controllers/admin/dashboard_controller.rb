class Admin::DashboardController < Admin::BaseController

  def show
    @service_request_groups = ServiceRequest.group(:product_category_id, :product_brand_id).count
  end
end