class Admin::ProductBrandsController < Admin::BaseController

  def create
    create! do |success, failure|
      success.js do
        if request.referer.include?('product_categories')
          render(:template => 'admin/product_brands/menu')
        else
          render_last_modal
        end
      end
      failure.js { render :new }
    end
  end
end