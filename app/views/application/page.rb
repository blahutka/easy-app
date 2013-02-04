# encoding: utf-8
class Views::Application::Page < Erector::Widget

  class << self
    def title(name=nil)
      @title = name if name
      @title
    end

    def sub_title(name=nil)
      @sub_title = name if name
      @sub_title
    end

  end

  def content
    page_header
    div class: 'row-fluid page-body' do
      page_body
    end
    super
  end

  def page_header
    header do
      div :class => 'page-header' do
        div class: 'row-fluid' do
          h2 class: 'pull-left' do
            self.title
            text nbsp
            self.sub_title
          end
          self.header_links
        end
        yield if block_given?
      end
    end
  end


  def title(name=nil)
    text self.class.title || name || resource_class.try(:model_name).try(:human)
  end

  def sub_title(name=nil)
    small do
      text! self.class.sub_title || name
    end
  end

  def header_links
  end

  def page_body
    yield if block_given?
  end

end