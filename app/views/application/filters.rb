#encoding: utf-8
class Views::Application::Filters < Erector::Widget
  FilterDefinition = Struct.new(:table_name, :attribute, :options)
  class << self

    def filter(*args)
      table_name = args[0]
      attribute = args[1] unless args[1].kind_of?(Hash)
      options = args.last

      filter_definitions << FilterDefinition.new(table_name, attribute, options)
    end

    def filter_definitions
      @filter_definitions ||= []
    end
  end

  def content
    div class: 'filters' do
      build_filters
      widget Views::Application::Tables::Filters::ButtonReset, :filter_name => resource_class.to_s.tableize.to_sym
    end
  end

  protected

  def filter_definitions
    self.class.filter_definitions
  end

  def build_filters
    filter_definitions.each do |filter_def|
      case filter_def.options[:as]
        when :dropdown
          dropdown_filter(filter_def)
      end

    end
  end

  def dropdown_filter(filter_def)
    # builds hash to set all queries to nil
    collection = filter_def.options[:collection]
    reset_queries = collection.map { |f| f.last.keys }.flatten.uniq.inject({}) { |all, v| all[v] = nil; all }

    default_filter = [[t('filters.disable'), reset_queries]]

    filter_list = (default_filter + collection).map do |values|
      link_name, query = values
      [link_name, collection_path({:action => :search}.merge(session_filter(filter_def.table_name, query.reverse_merge(reset_queries))))]
    end
    filter_name = filter_def.options[:label] || translate("#{filter_def.table_name.to_s.singularize}.#{filter_def.attribute}",
                                                          scope: 'activerecord.attributes')
    text! button_dropdown( filter_name, filter_list,
                          :class => 'btn-mini',
                          :icon => 'icon-filter',
                          :remote => true,
                          :divider => [0],
                          :active => proc { |link| current_filter?(filter_def.table_name,
                                                                   filter_def.options[:active], link) })
    default_filter = nil
  end
end