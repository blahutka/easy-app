# encoding: utf-8
module Bootstrap::ButtonsHelper

  def button_link(link_name, url, options={})
    icon = options[:icon].blank? ? nil : options[:icon]
    css_class = ['btn', options.delete(:class)].join(' ')

    Erector.inline do
      link_to(url, {:class => css_class}.merge(options)) do
        concat(content_tag(:i, :class => icon)) if icon
        concat(raw('&nbsp;')) if icon
        concat content_tag(:span) { link_name }
      end
    end.to_html(:helpers => self)
  end

  def button_dropdown(name, menu = [['Josef Svoboda', '#neco']], options={})
    icon = options[:icon] || 'user'
    css_class = ['btn dropdown-toggle', options[:class]].join(' ')

    Erector.inline do
      div :class => 'btn-group' do
        a :class => css_class, 'data-toggle' => "dropdown", :href => '#' do
          unless icon.blank?
            i(:class => icon)
            text nbsp
          end
          text nbsp
          text name
          text nbsp
          text nbsp
          span :class => 'caret'
        end
        ul :class => 'dropdown-menu' do
          menu.each_with_index do |item, i|
            is_active = options[:active].call(item.second) if options[:active] && options[:active].respond_to?(:call)
            li do
              a class: ('active' if is_active) ,:href => item.second, 'data-method' => options[:method], 'data-remote' => options[:remote] do
                text item.first
                text! nbsp
                i(:class => ('icon-ok' if is_active)) {}
              end
            end
            li class: 'divider' if options[:divider] && options[:divider].include?(i)
          end
        end
      end
    end.to_html(:helpers => self)
  end

  # args
  # :selected => proc { |link| link.include?(params[:state]) unless params[:state].blank? }
  def button_group(collection=[['Name', '#link_url']], args={})
    selected_btn = args[:selected] || nil
    style_class = ['btn', args[:class]].join(' ')

    Erector.inline do

      div :class => 'btn-group', :style => '' do
        collection.each do |btn|
          link_name, url, options = btn

          class_active = (selected_btn.call(url)) ? 'active' : nil if selected_btn
          if options
            badge = options[:badge] || nil
            icon = options[:icon] || nil
          end

          link_to(url, {:class => "#{style_class} #{class_active}"}.merge(options || {})) do
            if icon
              concat(content_tag(:i, :class => icon))
              concat(raw '&nbsp;')
            end
            concat raw link_name
            if badge
              concat(raw '&nbsp;')
              concat(content_tag(:span, :class => "badge #{badge[:class]}") { badge[:count].to_s })
            end
          end
        end
        #button :class => 'btn btn-mini' do
        #  #i :class => 'icon-search'
        #  text nbsp
        #  text 'Týden'
        #end
        #button :class => 'btn btn-mini' do
        #  #i :class => 'icon-search'
        #  text nbsp
        #  text 'Měsíc'
        #end
      end

    end.to_html(:helpers => self)
  end

=begin
<div class="span5">
      <div class="btn-group">
        <button class="btn">Dnes</button>
        <button class="btn">Týden</button>
        <button class="btn">Měsíc</button>
      </div>
    </div>
=end
end