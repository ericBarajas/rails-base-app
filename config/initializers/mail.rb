
# mail
Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.raise_delivery_errors = false
Rails.application.config.action_mailer.perform_deliveries = true

Rails.application.config.action_mailer.default_url_options = {
    :host => Rails.application.secrets.smtp[:host]
}


Rails.application.config.action_mailer.smtp_settings = {
    address:              Rails.application.secrets.smtp[:address],
    port:                 Rails.application.secrets.smtp[:port],
    domain:               Rails.application.secrets.smtp[:domain],

    user_name:            Rails.application.secrets.smtp[:user],
    password:             Rails.application.secrets.smtp[:password],

    authentication:       Rails.application.secrets.smtp[:authentication],
    openssl_verify_mode:  Rails.application.secrets.smtp[:openssl_verify_mode]
}


