class Users::InvitationMailer < BaseMailer

  def invite(user, password)
    @user = user
    @password = password

    mail(:to => user.email, :subject => 'Pozvanka do zkusebni aplikace EasyServis.cz')
  end
end