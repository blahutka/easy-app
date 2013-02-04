#encoding: utf-8
class Views::Admin::ProvisionServices::Table < Views::Application::Tables::Horizontal
  resource_class ProvisionService
  needs :options, :service_provider


  module Columns
    extend ActiveSupport::Concern

    included do
      column :product_category,
             proc { |column_id| sort_header(:provision_services, column_id, "product_category_name.desc") } do |provision_service|
        link_to provision_service.product_category, [:admin, provision_service.product_category]
      end

      column :product_brand,
             proc { |column_id| sort_header(:provision_services, column_id, "product_brand_name.desc") } do |provision|
        text provision.product_brand
      end

      column :service_provider,
             proc { |column_id| sort_header(:provision_services, column_id, "service_provider_company_name.desc") } do |provision|
        link_to provision.service_provider, [:admin, provision.service_provider]
      end

      column :primary_provider,
             proc { |column_id| sort_header(:provision_services, column_id, "primary_provider.desc") } do |provision|
        label_txt = t(provision.primary_provider.to_s, scope: 'boolean')
        active_btn = provision.primary_provider ? 'btn-success' : ''
        title_txt = provision.primary_provider ? 'Preferovaný' : 'Neaktivní'

        link_to label_txt,
                polymorphic_path([:admin, @service_provider, provision], 'provision_service[primary_provider]' => !provision.primary_provider),
                :remote => true, :method => :put, class: "btn btn-mini #{active_btn}",
                title: "#{title_txt} poskytovatel"
      end

      column :reward,
             proc { |column_id| sort_header(:provision_services, column_id, "percentage_and_money.desc") } do |provision_service|
        text provision_service.percentage.to_s + '%' if provision_service.percentage
        text provision_service.money.to_s + ' Kč' if provision_service.money
      end

      column :service_requests, nil do |provision_service|
        link_to provision_service.service_requests.count, [:admin, :service_orders]
      end

      column :service_orders, nil do |provision_service|
        link_to provision_service.service_orders.count, [:admin, provision_service.service_provider, :service_orders]
      end
    end
  end

  include Columns


  #columns self.respond_to?(:parent?) && parent? ? {:except => [:service_provider]} : {:except => []}

  action_buttons_inline(
      :edit => {
          remote: true,
          #url: 'edit_admin_service_provider_provision_service_path(obj.service_provider, obj)'
          url: 'edit_polymorphic_path([:admin, @service_provider, obj])'
      },
      :delete => {
          remote: true,
          url: 'polymorphic_path([:admin, @service_provider, obj])'
      },
      :show => false
  )


end

