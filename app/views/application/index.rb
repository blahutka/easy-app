#encoding: utf-8
class Views::Application::Index < Views::Application::Page


  def sub_title
    super("přehled")
  end


  def header_links(*attr)
    options = attr.last.is_a?(Hash) ? attr.last : {}

    div class: 'pull-right' do
      #filters_menu
      link_to new_resource_url, {class: 'btn btn-success'}.reverse_merge(options) do
        i class: 'icon-plus-sign icon-white'
        text nbsp
        text 'Přidat '
      end
    end
  end

  def page_header
    super do
      text!(render :partial => "filters", :formats => [:rb])
    end

  end

  def page_body
    render :partial => "table"
  end


  def filters_menu
    #text resource_class.columns.map(&:name)
    div class: 'btn-group filters', style: 'display:inline-block;' do
      text nbsp
      button 'Filtr', class: 'btn btn-mini'
      button class: 'btn btn-mini dropdown-toggle', 'data-toggle' => 'dropdown' do
        span class: 'caret'
      end
      ul class: 'dropdown-menu' do
        resource_class.columns.each do |column|
          li { link_to(column.name, '#', 'data-filter-type' => column.type) }
        end
      end
    end
  end


  class Table < Views::Application::Tables::Horizontal
    column :id, 'id' do |obj|
      obj.id
    end
  end
end