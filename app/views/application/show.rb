#encoding: utf-8
class Views::Application::Show < Views::Application::Page

  def sub_title(name=nil)
    super(name || resource.to_s)
  end

  def page_body
    super do
      form_preview
      yield if block_given?
    end
  end


  def form_preview(options={})
    widget TablePreview, :row_objects => exclude_attributes(resource, options), :object => resource
  end

  def header_links
    a href: edit_resource_path, class: 'pull-right btn' do
      i class: 'icon-pencil'
      text nbsp
      text 'Upravit'
    end
  end


  class TablePreview < Views::Application::Tables::Vertical
    column :attribute_name, '', width: '10%', class: 'attribute' do |attribute_name|
      strong @object.class.human_attribute_name(attribute_name)
    end

    column :attribute_value, '', width: '50%' do |attribute_name|
      association = attribute_name.sub(/_id$/, '')
      value = @object.respond_to?(association) ? @object.send(association) : @object.send(attribute_name)
      text case value
             when ActiveSupport::TimeWithZone
               l(value.to_date)
             else
               value
           end
    end

    #row_classes :even, :odd

  end

  protected

  def exclude_attributes(resource, options)
    remove = [].push(options.delete(:except)).flatten.map(&:to_s)
    resource.attributes.keys - remove
  end

end