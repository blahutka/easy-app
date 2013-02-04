# encoding: utf-8
class Views::Admin::Users::Table < Views::Application::Tables::Horizontal

  column :admin, nil, :th => {style: 'width:5%;'} do |user|
    text(user.admin ? 'ANO' : 'NE')
  end

  column :email, nil, :th => {style: 'width:10%;'} do |user|
    text user.email
  end

  column :account, nil do |user|
    link_txt = user.account.to_s.blank? ? 'Nevyplněn' : user.account.to_s
    link_to link_txt, admin_user_account_path(user)
  end

  column :order_count, nil do |user|
    text user.account.service_orders.count
  end

  action_buttons_inline
end