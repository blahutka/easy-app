#encoding: utf-8
class Views::Admin::ServiceProviders::Show < Views::Application::Show

  def header_links
    div :class => 'pull-right' do
      a href: edit_resource_path, class: 'btn' do
        i class: 'icon-pencil'
        text nbsp
        text 'Upravit'
      end
      text nbsp
      a href: new_resource_path, class: 'btn btn-success' do
        i class: 'icon-plus-sign icon-white'
        text nbsp
        text 'Přidat'
      end
    end
  end

  def page_body
    div class: 'row-fluid page-body' do
      div class: 'span8' do
        div class: 'row-fluid' do
          h6 'Poskytuje služby v kategoriích', class: 'pull-left'
          text nbsp; text nbsp
          link_to new_admin_service_provider_provision_service_path(@service_provider),
                  remote: true, :class => 'btn btn-mini btn-success go-back' do
            i class: 'icon-plus-sign icon-white'
            text nbsp
            text 'Přidat službu'
          end
        end
        render :partial => "admin/provision_services/table"
      end
      div class: :span4 do
        form_preview
      end
    end
  end
end
