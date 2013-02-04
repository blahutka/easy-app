#encoding: utf-8
class Views::Public::ServiceRequests::Edit < Views::Application::Edit

  title 'Začni se servisem zde'

  def page_body
    div class: 'span6' do
      render :partial => "form"
    end
  end

end