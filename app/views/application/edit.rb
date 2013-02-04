# encoding: utf-8
class Views::Application::Edit < Views::Application::Page

  def sub_title(name=nil)
    super name || "#{resource.to_s} aktualizovat"
  end

  def page_body
    render :partial => "form"
  end


end