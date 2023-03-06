# Action Mailer configuration with Sendgrid

config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  user_name: 'apikey',
  password: ENV['SENDGRID_API_KEY'],
  domain: 'localhost:3000',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
