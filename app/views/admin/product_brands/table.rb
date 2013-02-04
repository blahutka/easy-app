class Views::Admin::ProductBrands::Table < Views::Application::Tables::Horizontal
    column :name, nil do |brand|
      text brand.name
    end

    action_buttons_inline(
        :edit => {:url => 'edit_admin_product_brand_path(obj)'},
        :show => {:url => 'admin_product_brand_path(obj)'},
        :delete => {:url => 'admin_product_brand_path(obj)', :remote => true}

    )
end