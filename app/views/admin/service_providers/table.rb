class Views::Admin::ServiceProviders::Table < Views::Application::Tables::Horizontal
  resource_class ServiceProvider

  column :company_name, proc { |column_id| sort_header(:service_providers, column_id, "company_name.desc") } do |provider|
    link_to provider.company_name, resource_url(provider)
  end

  column(:full_address, nil) { |provider| text [provider.street, provider.city].join(', ') }

  column :provision_services, nil do |provider|
    out = ''
    provider.provision_services.includes(:product_category, :product_brand).
        group_by { |v| v.product_category.try(:name) }.each do |group_name, service|
      strong group_name
      text ': '
      text service.map { |v| v.product_brand.to_s }.join(', ')
      br
    end

  end

  column(:service_orders, nil) do |provider|
    link_to ('<i class="icon-eye-open"></i>&nbsp;' +provider.service_orders.count.to_s).html_safe,
            admin_service_provider_service_orders_path(provider), class: 'btn btn-mini'
  end

  action_buttons_inline(:show => false, :edit => {remote: true})

end