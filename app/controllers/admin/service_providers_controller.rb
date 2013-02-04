class Admin::ServiceProvidersController < Admin::BaseController
  custom_actions :collection => :search
  respond_to :html, :js

  def index
    index!
  end

  def show
    show!
  end

  def create
    create! do |success, failure|
      success.js do
        render_last_modal
      end
      failure.js { render :new }
    end
  end

  protected
  def collection
    @service_providers ||= end_of_association_chain.
        search(filters_for(:service_providers)).
        paginate(:per_page => 10, :page => params[:page].presence || 1)
  end
end