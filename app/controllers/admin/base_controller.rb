class Admin::BaseController < ApplicationController
  inherit_resources
  before_filter :authenticate
  before_filter :store_location

  respond_to :html, :js


  def update
    update! do |success, failure|
      failure.js { render('edit') }
    end
  end

  def create
    create! do |success, failure|
      failure.js { render 'new' }
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      user = User.where(email: username, admin: true).first
      user and user.valid_password?(password) ? sign_in(user) : false
    end
    warden.custom_failure! if performed?
  end

  def store_location
    session[:return_to] = request.referer if request.get? and controller_name != "user_sessions" and controller_name != "sessions"
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
  end

  #after_filter :back_to_modal

  def render_last_modal
    if request.xhr?
      render(:js => "$.get('#{session[:return_to]}.js');")
    end
  end


end