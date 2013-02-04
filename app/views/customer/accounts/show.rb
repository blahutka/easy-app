# encoding: utf-8
class Views::Customer::Accounts::Show < Views::Application::Show

  def sub_title
    super("#{resource.first_name} #{resource.last_name}".presence || current_user.email)
  end

  def page_body

    div class: 'row-fluid' do
      div class: 'span5' do
        link_to '<i class="icon-lock"></i> Změnit heslo'.html_safe, edit_customer_account_path, class: 'btn btn-small'
      end
    end

    hr class: 'spacer'
    form_preview

  end


end