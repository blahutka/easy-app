# encoding: utf-8
class Public::ServiceRequestsController < Public::BaseController
  inherit_resources
  check_form_for_spam :time_to_fill => 8.seconds
  respond_to :html, :pdf
  #before_filter :login_user, :only => :create
  #before_filter :account, :only => [:new, :create]


  def create
   save_and_register_or_login
  end

  def update
    @service_request = ServiceRequest.new(params[:service_request])
    save_and_register_or_login
  end

  protected
  def build_resource
    @service_request ||= end_of_association_chain.find_by_session_id(service_request_id) ||
        ServiceRequest.new(params[:service_request])
    @service_request.session_id = service_request_id
    @service_request
  end

  def save_and_register_or_login
    @service_request ||= build_resource
    @service_request.valid?

    if login_user && @service_request.valid?
      @service_request.save
      redirect_to(service_request_path(resource.session_id))
    elsif (@user = can_register) && @service_request.valid?
      @user.save!
      @service_request.save
      @user.deliver_invitation
      flash[:notice] = "Heslo pro vstup na Váš učet bylo odesláno na email #{@user.email}"
      sign_in(@user)
      redirect_to(customer_service_request_path(resource.session_id))
    else
      render('new') and return
    end
  end

  def login_user
    if not signed_in?
      if  params[:service_request][:switch][:account].include?('login')
        credentials = params[:service_request][:user]
        user = User.where(email: credentials[:email]).first
        @user = (user and user.valid_password?(credentials[:password])) ? sign_in(user) : false
        flash[:alert] = "Nepodařilo se přihlásit. Neplatný email nebo heslo. #{view_context.link_to('Zapomněli jste heslo?', new_user_password_path, target: '_blank')}".html_safe unless @user
        return @user
      end
    end
  end

  def can_register
    if not signed_in?
      if  params[:service_request][:switch][:account].include?('register')
        @customer_account = CustomerAccount.new(params[:service_request][:customer_account])
        @user = User.new

        return false if not @customer_account.valid?

        @user.account = @customer_account
        @user.generate_credentials

        if not @user.valid?
          @customer_account.errors.add(:email, 'Email jiz existuje')
          return false
        end
      end
    end

    return @user
  end

end