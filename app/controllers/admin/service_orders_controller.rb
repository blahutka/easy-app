class Admin::ServiceOrdersController < Admin::BaseController
  belongs_to :service_provider, :optional => true, :polymorphic => true
  custom_actions :collection => :search
  respond_to :html, :js


  protected

  def collection
    @service_orders ||= end_of_association_chain.
        joins([{:service_request => [:product_brand, :product_category]}]).
        search(filters_for(:service_orders)).
        paginate(:per_page => 15, :page => params[:page].presence || 1)
  end
end