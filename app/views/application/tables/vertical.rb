class Views::Application::Tables::Vertical < Views::Application::Tables::Default
  needs :object, :row_objects, :collection => [] , :options => {}

  # The standard erector content method.
  def content
    table class: 'table table-bordered' do
      thead do
        tr class: 'well' do
          th colspan: 2 do
            h6 @object.class.model_name.human
          end
        end
      end
      tbody do
        @row_objects.each_with_index do |object, index|
          row object, index
        end
      end
    end
  end

  protected
  def row(object, index) #:nodoc:
    tr(:class => row_css_class(object, index)) do
      column_definitions.each do |column_def|
        td column_def.options do
          self.instance_exec(object, &column_def.cell_proc)
        end
      end
    end
  end

end

