#encoding: utf-8
class Views::Customer::Dashboard::Filters < Views::Admin::ServiceOrders::Filters

  filter :service_orders, :as => :dropdown, :label => 'Stav zakázky', :active => :state_eq, :collection => [
       ['Nové', state_eq: 'new'],
       ['Pracuje se', state_eq: 'working'],
       ['Připravené', state_eq: 'ready'],
       ['Ukončené', state_eq: 'finished']
   ]

   filter :service_orders, :as => :dropdown, :label => 'Značka',
          :active => :service_request_product_brand_id_eq,
          :collection => ProductBrand.all.map { |v| [v.name, service_request_product_brand_id_eq: v.id] }

   filter :service_orders, :as => :dropdown, :label => 'Kategorie',
          :active => :service_request_product_category_id_eq,
          :collection => ProductCategory.all.map { |v| [v.name, service_request_product_category_id_eq: v.id] }


end