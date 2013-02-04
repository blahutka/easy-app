#encoding: utf-8
class Views::Customer::Dashboard::Index < Views::Application::Index

  title 'Objednávky'

  def header_links
    new_customer_service_order
  end

  private

  def new_customer_service_order
    div class: 'pull-right' do
      link_to new_customer_service_request_path, :class => 'btn btn-success', :id => 'new_service_request' do
        i class: "icon-plus-sign icon-white"
        text nbsp; text 'Objednat servis'
      end
    end
  end
end
