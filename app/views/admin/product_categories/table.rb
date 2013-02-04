class Views::Admin::ProductCategories::Table < Views::Application::Tables::Horizontal

  resource_class ProductCategory

  column :name, nil do |category|
    link_to category.name, resource_url(category)
  end

  column :brands, nil do |category|
    text category.product_brands.map(&:name).join(', ')
  end

  action_buttons_inline

end