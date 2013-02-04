# encoding: utf-8
module Bootstrap::AlertsHelper

  def alert_block(*args, &block)
    type = ( args[0].is_a?(Hash) ? '' : args[0] )
    options = args[1] || args[0] || {}
    style = ['alert', "alert-#{type.to_s}", 'alert-block']
    show_close = options.include?(:close) ? options[:close] : true
    #binding.pry

    Erector.inline do
      div :class => style.join(' ') do
        link_to('&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert') if show_close
        h4(options[:title], :class => 'alert-heading') if options[:title].present?
        text! yield if block_given?
      end
    end.to_html
  end


=begin
<div class="alert alert-block">
    <a class="close" data-dismiss="alert">×</a>
    <h4 class="alert-heading">Warning!</h4>
    Best check yo self, you're not...
    </div>
=end

  def alert_inline(*args, &block)
    type = ( args[0].is_a?(Hash) ? '' : args[0] )
    options = args[1] || {}
    show_close = options.delete(:close) || true
    style = ['alert', "alert-#{type.to_s}"]

    Erector.inline do
      div :class => style.join(' ') do
        link_to('&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert') if show_close
        strong(options[:title]+': ') if options[:title].present?
        text! nbsp
        text! yield if block_given?
      end
    end.to_html
  end

  def alert_inline_form()
    type = notice ? :info : :error
    title = title == :info ? 'Poznámka' : 'Problém'
    alert_inline(type, :title => title, :close => false) { notice || alert } if notice || alert
  end

=begin
  <div class="alert">
    <a class="close" data-dismiss="alert"> ×</a>
    <strong>Warning!</s trong> Best check yo self, you 're not looking too good.
  </div>
=end
end