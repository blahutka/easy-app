class Views::Public::ServiceRequests::New < Views::Application::New

  def page_body
    div class: 'span6' do
      render :partial => "form"
    end

  end

end