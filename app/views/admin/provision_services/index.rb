#encoding: utf-8
class Views::Admin::ProvisionServices::Index < Views::Application::Index

  def page_body
    super
  end

  def header_links
    div class: 'pull-right' do
         link_to new_resource_url, class: 'btn btn-success go-back', remote: true do
           i class: 'icon-plus-sign icon-white'
           text nbsp
           text 'Přidat '
         end
       end
  end
end