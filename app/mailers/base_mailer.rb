class BaseMailer < ActionMailer::Base
  layout 'mailer'
  default :from => "info@easyservice.cz"

  # VIEWS TEMPLATES CORRECTS PATH
  def self.mailer_name
    "mailers/#{name.underscore}"
  end

  class EmailDeliveryException < RuntimeError
  end
end