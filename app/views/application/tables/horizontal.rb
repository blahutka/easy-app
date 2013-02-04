#encoding: utf-8
class Views::Application::Tables::Horizontal < Views::Application::Tables::Default
  needs :options => {}

  def content
    table class: ['table table-striped', resource_class ? dom_class(resource_class, :table) : 'table_empty'] do
      caption do
        text! page_entries_info(@collection)
      end
      thead do
        tr do
          column_definitions.each do |column_def|
            th column_def.options[:th], :id => column_def.id do
              if column_def.name.is_a?(Proc)
                self.instance_exec(column_def.id, &column_def.name)
              else
                self.resource_class.respond_to?(:human_attribute_name) ?
                    text(self.resource_class.human_attribute_name(column_def.id)) : text(column_def.id)
              end
            end
          end
        end
      end
      tbody do
        if @collection.any?
          @collection.each_with_index do |object, index|
            row object, index
          end
        else
          tr do
            td class: 'no-entry', colspan: column_definitions.size do
              text t('tables.no_entry')
            end
          end
        end
      end
      tfoot do
        tr do
          td(:colspan => self.class.columns.size) { pagination(@collection) }

        end
      end
    end

  end

  def pagination(collection)
    text! will_paginate(collection, {:class => 'pagination', :inner_window => 2, :outer_window => 0,
                                     :renderer => NewLinkRenderer,
                                     :previous_label => '&larr;'.html_safe,
                                     :next_label => '&rarr;'.html_safe, :remote => true})
    javascript('$(".pagination").find("a").attr("data-remote", true);')
  end

  def build_url(type, options, obj)

    options[type][:url] ? instance_eval(options[type][:url]) : case type
                                                                 when :delete then
                                                                   resource_url(obj)
                                                                 when :edit then
                                                                   edit_resource_url(obj)
                                                                 when :show then
                                                                   resource_url(obj)
                                                               end
  end

  def self.action_buttons_inline(options={})
    options.reverse_merge!(:delete => {}, :edit => {}, :show => {})
    column :actions, nil, th: {class: 'actions'}, td: {class: 'actions'} do |obj|

      if options[:show]
        link_to('<i class="icon-eye-open"></i>'.html_safe,
                build_url(:show, options, obj),
                options[:show].reverse_merge!(remote: false, :id => dom_id(obj, :show), title: 'Detail', :class => 'btn btn-mini'))
      end
      if options[:edit]
        text nbsp
        link_to('<i class="icon-edit"></i>'.html_safe, build_url(:edit, options, obj),
                options[:edit].reverse_merge!(remote: false, :id => dom_id(obj, :edit), title: 'Upravit', class: 'btn btn-mini'))
      end
      if options[:delete]
        text nbsp
        link_to('<i class="icon-trash"></i>'.html_safe, build_url(:delete, options, obj),
                options[:delete].reverse_merge!(remote: false, :confirm => "Are you sure?",
                                                :method => :delete, title: 'Smazat', class: 'btn btn-mini'))
      end
    end
  end

  def self.action_buttons(options={})
    options.reverse_merge!(:delete => {}, :edit => {}, :show => {})

    column :actions, nil, th: {class: 'actions'}, td: {class: 'actions'} do |obj|
      div class: 'btn-group' do
        a href: '#', class: 'btn btn-mini dropdown-toggle', 'data-toggle' => :dropdown do
          i class: 'icon-tasks'; text nbsp; text nbsp;
          span class: :caret
        end
        ul class: 'dropdown-menu' do
          if options[:show]
            url = options[:show][:url] ? instance_eval(options[:show][:url]) : resource_url(obj)
            li do
              link_to('<i class="icon-eye-open"></i>&nbsp;&nbsp;Detail'.html_safe,
                      url, options[:show].reverse_merge!(remote: false, :id => dom_id(obj, :show)))
            end
          end
          if options[:edit]
            url = options[:edit][:url] ? instance_eval(options[:edit][:url]) : edit_resource_url(obj)
            li do
              link_to('<i class="icon-edit"></i>&nbsp;&nbsp;Upravit'.html_safe,
                      url,
                      options[:edit].reverse_merge!(remote: false, :id => dom_id(obj, :edit)))
            end
          end
          if options[:delete]
            url = options[:delete][:url] ? instance_eval(options[:delete][:url]) : resource_url(obj)
            li do
              link_to('<i class="icon-trash"></i>&nbsp;&nbsp;Smazat'.html_safe,
                      url,
                      options[:delete].reverse_merge!(remote: false, :confirm => "Are you sure?", :method => :delete))
            end
          end
        end
      end
    end
  end

  # TODO refactor put to initializer
  require 'will_paginate/view_helpers/action_view'

  class NewLinkRenderer < ::WillPaginate::ActionView::LinkRenderer

    def url(page)
      @base_url_params ||= begin
        url_params = merge_get_params(default_url_params)
        merge_optional_params(url_params)
      end

      url_params = @base_url_params.dup
      add_current_page_param(url_params, page)

      # call to inherited_resource helper
      @template.collection_url(url_params)
    end

    protected


    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

end