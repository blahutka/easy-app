#encoding: utf-8
class Views::Application::Tables::Default < Erector::Widget
  needs :collection

  ColumnDefinition = Struct.new(:id, :name, :options, :cell_proc)

  #class_attribute :display_columns

  class << self

    def column(id, name=id.to_s.titleize, options={}, &cell_proc)
      cell_proc ||= proc { |object| text object.__send__(id) }
      column_definitions << ColumnDefinition.new(id, name, options, cell_proc)
    end

    def column_definitions #:nodoc:
      @column_definitions ||= []
    end

    def columns(config={})
      col = column_definitions.dup
      col.delete_if { |c| config[:except].include?(c.id) } if config[:except].presence
      col.delete_if { |c| !config[:only].include?(c.id) } if config[:only].presence
      col
    end

    def display_columns(config= {})
      @display_columns ||= config
    end

    def row_classes(*row_classes)
      @row_class_list = row_classes
    end

    def resource_class(class_name = nil)
      @resource_class = class_name if class_name
      @resource_class
    end

    attr_reader :row_class_list
  end

  # The standard erector content method.
  def content
    table do
      thead do
        tr do
          column_definitions.each do |column_def|
            th column_def.options do
              if column_def.name.is_a?(Proc)
                self.instance_exec(column_def.id, &column_def.name)
              else
                text column_def.name
              end
            end
          end
        end
      end
      tbody do
        @collection.each_with_index do |object, index|
          row object, index
        end
      end
    end
    text! pagination(@collection)
  end

  def pagination(collection)
    if collection.respond_to? :paginate
      text! page_navigation_links(collection, :class => 'pagination pagination-right')
    end
  end

  protected
  def row(object, index) #:nodoc:
    tr(:class => row_css_class(object, index)) do
      column_definitions.each do |column_def|
        resource = object
        td column_def.options[:td] do
          self.instance_exec(object, &column_def.cell_proc)
        end
      end
    end
  end

  def row_css_class(object, index)
    cycle(index)
  end

  def row_options
    @row_options = column_def.options.delete('row')
  end

  def column_definitions #:nodoc:
    self.class.columns(self.class.display_columns)
  end

  def sort_header(table_name, column_id, default_query)
    current_query = get_filter(table_name, :meta_sort)
    if current_query && is_active = current_query.sub(/\.asc|\.desc/, '') == default_query.sub(/\.asc|\.desc/, '')
      query = current_query.include?('.desc') ? current_query.sub('.desc', '.asc') : current_query.sub('.asc', '.desc')
    else
      query = default_query.include?('.desc') ? default_query.sub('.desc', '.asc') : default_query.sub('.asc', '.desc')
    end
    translated_link = self.resource_class.respond_to?(:human_attribute_name) ?
        self.resource_class.human_attribute_name(column_id) : column_id

    link_to(translated_link, collection_path({:action => :search}.merge(session_filter(table_name, "meta_sort" => query))),
            class: ('active' if is_active), remote: true)
  end

  def cycle(index) #:nodoc:
    list = self.class.row_class_list
    list ? list[index % list.length] : ''
  end

  def resource_class
    #TODO get class
    # self.class.parent.to_s.split('::').last.singularize
    @collection.present? ? @collection.first.class : self.class.resource_class
  end

  # rails method is overwritten by erector
  def dom_id(record, prefix = nil)
    if record_id = record_key_for_dom_id(record)
      "#{dom_class(record, prefix)}_#{record_id}"
    else
      dom_class(record, prefix || 'new')
    end
  end
end