# encoding: utf-8
class Views::Application::New < Views::Application::Page

  def sub_title
    super "přidat"
  end

  def page_body
      render :partial => "form"
  end


end