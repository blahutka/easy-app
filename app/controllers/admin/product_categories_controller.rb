class Admin::ProductCategoriesController < Admin::BaseController

  def index
    index! {}
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
    @product_categories ||= end_of_association_chain.paginate(:per_page => 20, :page => params[:page].presence || 1)
  end
end