class Admin::ProvisionServicesController < Admin::BaseController
  belongs_to :service_provider, optional: true
  custom_actions :collection => :search
  respond_to :html, :js


  def index
    index! {}
  end

  def create
    create! do |success, failure|
      success.html { redirect_to(resource_url) }
      failure.js { render('new') }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to(resource_url) }
      failure.js { render('edit') }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to(admin_service_provider_path(@service_provider)) }
    end
  end

  protected
  #FIX this resource cannot find url in pagination
  def index_admin_provision_services_url(options = {})
    collection_url(options)
  end

  def collection
    @provision_services ||= end_of_association_chain.
        joins(:product_category, :product_brand).
        search(filters_for(:provision_services)).
        paginate(:per_page => 10, :page => params[:page].presence || 1)
  end
end
