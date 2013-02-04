module Bootstrap::TablesHelper

  def table_default(collection = nil, &block)
    clazz = collection.first.class if collection.any?
    columns = {}
    filters = {}
    block.call(columns, filters) if block_given?

    Erector.inline do

      table :class => ['table table-striped', clazz ? dom_class(clazz, :table) : 'table_empty'] do
        thead do
          tr do
            columns.each do |key, col|
              th do
                clazz.respond_to?(:human_attribute_name) ? text(clazz.human_attribute_name(key)) : text(key)
              end
            end
          end
        end if collection.any?
        tbody do
          collection.each do |obj|
            text! row(obj, columns)
          end
        end if collection.any?
      end
      text! pagination(collection)
    end.to_html(:helpers => self)

  end

  def column(pr = nil, options={}, &block)
    bl = block if block_given?
    {:options => options, :content => (pr || bl)}
  end


  def row(obj, columns_config)
    Erector.inline do
      tr do
        columns_config.each do |key, col|
          td(col[:options]) do
            text! (col[:content].respond_to?(:call) ? col[:content].call(obj) : col[:content])
          end
        end
      end
    end.to_html(:helpers => self)
  end

  def pagination(collection)
    if collection.respond_to? :paginate
      page_navigation_links(collection, :class => 'pagination pagination-right')
    end
  end

end