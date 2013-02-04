#encoding: utf-8
class Views::Customer::ServiceOrders::Table < Views::Application::Tables::Horizontal
  resource_class ServiceOrder
  include Views::Admin::ServiceOrders::Table::Columns

  display_columns :only => [:id, :updated_at, :state, :serial_num, :product_category, :product_brand, :actions]


  action_buttons_inline(
      :show => {remote: false, url: 'customer_service_order_path(obj)'},
      :edit => {remote: false, url: 'edit_customer_service_order_path(obj)'},
      :delete => {remote: true, url: 'customer_service_order_path(obj)'}
  )


end