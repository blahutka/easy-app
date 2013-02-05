#encoding: utf-8
class Views::Admin::Dashboard::Show < Views::Application::Show

  def title
    super('Dashboard')
  end

  def sub_title
    super('services overview')
  end

  def page_body
    super do
      @service_request_groups.each do |category_brand, count|
        category_id, brand_id = category_brand

        div class: 'row-fluid' do
          div class: 'span1' do
            div class: :span5 do
               span class: 'badge badge-warning' do
                 link_to(count, admin_service_orders_path, :style => 'color:white')
               end
            end
            div class: :span7 do
              h5 {small( count > 1 ? 'new' : 'new')}
            end
            h6 count > 1 ? 'orders' : 'order'
          end
          div class: :span10 do
            h3 { text ProductCategory.find(category_id); text(nbsp); small ProductBrand.find(brand_id) }
            text 'Providers: '
            service_providers(category_id, brand_id)
          end
        end
        hr
      end
    end
  end

  def service_providers(category_id, brand_id)
    @poviders = ProvisionService.includes(:service_provider).where(:product_category_id => category_id, :product_brand_id => brand_id)
    @poviders.collect {|v| link_to(v.service_provider.company_name, [:admin, v.service_provider]); text(', ')  }
  end


  def form_preview
  end

  def header_links
  end


end