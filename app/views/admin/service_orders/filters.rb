#encoding: utf-8
class Views::Admin::ServiceOrders::Filters < Views::Application::Filters
  # MetaSearch query

  filter :service_orders, :state, :as => :dropdown, :active => :state_eq, :collection => [
      ['Nové', state_eq: 'new'],
      ['Pracuje se', state_eq: 'working'],
      ['Připravené', state_eq: 'ready'],
      ['Ukončené', state_eq: 'finished']
  ]

  filter :service_orders, :product_brand, :as => :dropdown,
         :active => :service_request_product_brand_id_eq,
         :collection => ProductBrand.all.map { |v| [v.name, service_request_product_brand_id_eq: v.id] }

  filter :service_orders, :product_category, :as => :dropdown,
         :active => :service_request_product_category_id_eq,
         :collection => ProductCategory.all.map { |v| [v.name, service_request_product_category_id_eq: v.id] }

  filter :service_orders, :provider, :as => :dropdown,
         :active => :service_provider_id_eq,
         :collection => [['Nepřidělen žádný', service_provider_id_is_null: true]] +
             ServiceProvider.all.map { |v| [v.company_name, service_provider_id_eq: v.id] }

  def content
    hr
    super
  end

  protected

  def search_text
    # TEST MULTI SEARCH FORM
    #form_for 'search[service_orders]', :url => collection_path({:action => :search}), :remote => true do |f|
    #  f.select 'multi_type(1)', [
    #      ['Popis obsahuje', 'service_request_defect_description_contains'],
    #      ['Popis začíná na', 'service_request_defect_description_starts_with'],
    #      ['Popis končí na', 'service_request_defect_description_ends_with']
    #  ]
    #  f.text_field 'multi_type(2)', :value => get_filter(:service_orders, 'multi_type(2)')
    #  f.submit 'Hledej', class: 'btn'
    #end
  end
end