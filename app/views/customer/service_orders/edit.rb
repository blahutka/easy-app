class Views::Customer::ServiceOrders::Edit < Views::Application::Edit

  def sub_title
    super "#{resource.to_s} <span class='label'>#{resource.try(:state)}</span> "
  end

  def page_body
    div class: 'span6' do
      render :partial => "form"
    end
  end

end