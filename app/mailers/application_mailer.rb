class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.smtp[:default_from]

  layout 'mailer'
end
