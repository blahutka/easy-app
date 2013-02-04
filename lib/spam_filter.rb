module SpamFilter
  extend ActiveSupport::Concern


  module ClassMethods
    # setup spam checking in controller
    def check_form_for_spam(var= nil)
      var ? @check_spam_options = var : @check_spam_options
    end
  end

  module InstanceMethods

    protected

    def check_spam(options={:input_email => :email, :input_timestamp => :timestamp, :time_to_fill => 5.seconds})
      options.merge!(self.class.check_form_for_spam)

      redirect_to(:back, :alert => 'Vyhodnoceno jako spam.&nbsp;<a href="/">Zkus znovu</a>') if \
        spam?(params[options[:input_timestamp]], options[:time_to_fill], params[options[:input_email]])
    end

    # is true if time is less then OR email is set
    def spam?(form_created = Time.zone.now.to_s, time = 3, email)
      return (Time.zone.parse(Base64.decode64(form_created)) > Time.zone.parse(time.ago.to_s) ||
          !email.blank?)
    end

    def spam_timestamp_tag
      out = view_context.hidden_field_tag :timestamp, Base64.encode64(Time.zone.now.to_s)
      out << view_context.text_field_tag(:email, nil, :style => 'display:none;')
    end


  end

  def self.included(base)
    base.send(:helper_method, :spam_timestamp_tag)

    base.before_filter(:only => :create) do |controller|
      controller.send(:check_spam) if self.class.check_form_for_spam
    end
  end

end

class ActionController::Base
  include SpamFilter
end