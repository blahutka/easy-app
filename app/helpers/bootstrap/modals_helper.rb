module Bootstrap::ModalsHelper

  def modal(*args, &block)
    id = (args[0].is_a?(Hash) ? 'popupModal' : args[0])
    options = args[1] || args[0] || {}
    fixed = (options.include?(:fixed) ? options[:fixed] : !request.xhr?)
    modal_class = ['modal']
    modal_class << (fixed ? 'fixed' : 'hide fade')
    buttons = []
    body = []
    block.call(body, buttons) if block_given?

    Erector.inline do

      div :class => modal_class.join(' '), :id => id do
        div :class => 'modal-header' do
          a('x', {:class => 'close', 'data-dismiss' => 'modal'})
          h3 options[:title].presence || 'My Title'
        end

        #simple_form_for :user do |f|
        #div :class => 'modal-body' do
        #    text! f.input :email
        #    #text! f.instance_eval(body.first.call)
        #    #body.each { |v| text! f.instance_eval(v.call) }
        #    #body.each { |v| text! v.call }
        #    #text! f.instance_eval{ body.first.call}
        body.each { |v| text! v.call }
        #div :class => 'modal-footer' do
        #    #buttons.each { |v| text! f.send(v[:f], :class => v[:class]) ; text nbsp  }
        #    #text! f.instance_eval(buttons.each{|v| v.call})
        #    buttons.each { |v| text! f.instance_eval(v.call) }
        #end
        #end


      end

    end.to_html(:helpers => self)
  end

  def modal_test
    id = (args[0].is_a?(Hash) ? 'popupModal' : args[0])
    options = args[1] || args[0] || {}
    fixed = (options.include?(:fixed) ? options[:fixed] : !request.xhr?)
    modal_class = ['modal']
    modal_class << (fixed ? 'fixed' : 'hide fade')
    buttons = []
    body = []
    block.call(body, buttons) if block_given?

    Erector.inline do

      div :class => modal_class.join(' '), :id => id do
        div :class => 'modal-header' do
          a('x', {:class => 'close', 'data-dismiss' => 'modal'})
          h3 options[:title].presence || 'My Title'
        end
        div :class => 'modal-body' do
          form_for :search do |f|
            binding.pry
            render :partial => "accounts/contracts/form/technician", :object => f, :locals => {f: f}
          end
        end
      end

    end.to_html(:helpers => self)
  end

=begin
 <div class="modal" id="myModal">
  <div class="modal-header">
  <a class="close" data-dismiss="modal">×</a>
  <h3>Modal header</h3>
  </div>
  <div class="modal-body">
  <p>One fine body…</p>
  </div>
  <div class="modal-footer">
  <a href="#" class="btn btn-primary">Save changes</a>
  <a href="#" class="btn">Close</a>
  </div>
  </div>
=end
end
