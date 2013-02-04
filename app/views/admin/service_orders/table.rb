#encoding: utf-8
class Views::Admin::ServiceOrders::Table < Views::Application::Tables::Horizontal
  module Columns
    extend ActiveSupport::Concern

    included do
      column :id, nil, width: '5%' do |order|
        text order.id
      end

      column :updated_at, proc { |column_id| sort_header(:service_orders, column_id,  "updated_at.desc") }, width: '10%' do |order|
        text 'před '
        text time_ago_in_words(order.try(:updated_at))
      end

      column :state, proc { |column_id| sort_header(:service_orders, column_id,  "state.desc") } do |order|
        span(order.state, :class => 'label')
      end

      column :serial_num, proc { |column_id| sort_header(:service_orders, column_id,  "service_request_serial_num.desc") } do |order|
        text order.service_request.serial_num
      end

      column :product_category, proc { |column_id| sort_header(:service_orders, column_id,  "service_request_product_category_name.desc") } do |order|
        text order.service_request.product_category.try(:name)|| 'n/a'
      end

      column :product_brand, proc { |column_id| sort_header(:service_orders, column_id,  "service_request_product_brand_name.desc") } do |order|
        text order.service_request.product_brand.try(:name)|| 'n/a'
      end

      column :service_provider, proc { |column_id| sort_header(:service_orders, column_id, "service_provider_company_name.desc") } do |order|
        if order.service_provider.try(:company_name)
          link_to order.service_provider.company_name, [:admin, order.service_provider]
        else
          text 'n/a'
        end
      end
    end
  end



  include Columns
  resource_class ServiceOrder
  action_buttons_inline(:show => {remote: true}, :edit => {remote: true}, :delete => {remote: true})

end
