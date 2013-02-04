#encoding: utf-8
class Views::Public::ServiceRequests::Show < Views::Application::Show

  def header_links

  end

  def form_preview
    div class: 'row-fluid' do
      if signed_in?

        if current_account.invalid?
          finish_registration
        else
          text! submit_service_order
        end
        edit_service_request(edit_customer_service_request_path(service_request_id))

      else # NOT SIGNED IN USER
        edit_service_request(edit_service_request_path(service_request_id))
        text nbsp; text 'nebo pokračovat'; text nbsp
        register_or_login
      end
    end
    hr
    super(:except => ['id', 'session_id', 'slug', 'defect_description_edited'])
  end

  def submit_service_order
    simple_form_for([:customer, ServiceOrder.new], html: { class: 'form-inline span2' }) do |f|
      button_tag class: 'btn btn-success', id: 'submit_service_request' do
        text 'Odeslat žádost'; text nbsp
        i class: 'icon-ok-circle icon-white'
      end
    end
  end

  def edit_service_request(url)
    link_to url, :class => 'btn btn-mini pull-left', :id => 'edit_service_request' do
      i class: "icon-pencil"
      text nbsp; text 'Upravit žádost'
    end
  end

  def finish_registration
    div class: "alert alert-success" do
      h4 'Vítejte!', class: "alert-heading"
      p 'a děkujeme za Váš login/registraci. Nyní zbývá jen doplnit pár osobních údajů aby byla žádost o službu kompletní.'
      link_to 'Dokonči registraci', edit_customer_account_path, :class => 'btn btn-primary', :id => 'edit_customer_account'
    end
  end

  def register_or_login
    link_to 'Přihlášení/Registrace', customer_service_request_path(service_request_id),
            :class => 'btn btn-primary', :id => 'submit_service_request'
  end

end