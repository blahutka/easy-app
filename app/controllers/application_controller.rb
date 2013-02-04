require_dependency "spam_filter"
require_dependency 'session_filters'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :service_request_id
  helper_method :current_account, :is_admin?
  before_filter :set_language

  protected

  def service_request_id
    session['service_request_id'] ||= Digest::SHA1.hexdigest(Time.now.to_s)
  end

  def current_account
    @current_account ||= current_user.try(:account)
  end

  def is_admin?
    @is_admin.presence
  end

  def set_language
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
