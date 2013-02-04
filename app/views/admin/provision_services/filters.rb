#encoding: utf-8
class Views::Admin::ProvisionServices::Filters < Views::Application::Filters
  # MetaSearch query
  filter :provision_services, :product_category, :as => :dropdown,
         :active => :product_category_id_eq,
         :collection => ProductCategory.all.map { |v| [v.name, product_category_id_eq: v.id] }

  filter :provision_services, :product_brand, :as => :dropdown,
         :active => :product_brand_id_eq,
         :collection => ProductBrand.all.map { |v| [v.name, product_brand_id_eq: v.id] }

  filter :provision_services, :primary_provider, :as => :dropdown,
         :active => :primary_provider_eq,
         :collection => [
             [I18n.translate("boolean.'true'"), primary_provider_eq: true],
             [I18n.translate("boolean.'false'"), primary_provider_eq: false],
         ]

  filter :provision_services, :service_provider, :as => :dropdown,
         :active => :service_provider_id_eq,
         :collection => ServiceProvider.all.map { |v| [v.company_name, service_provider_id_eq: v.id] }

  def content
    hr
    super
  end

end