# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# config.action_mailer.raise_delivery_errors = true


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'mail.google.com',
  :port           => 587,
  :user_name      => ENV['GMAIL_USERNAME'],
  :password       => ENV['GMAIL_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}

# config.action_mailer.delivery_method = :smtp

# config.action_mailer.smtp_settings = {
#   address: 'smtp.gmail.com'
#   port: 587
#   user_name: ENV['GMAIL_USERNAME']
#   password: ENV['GMAIL_PASSWORD']
#   authentication: 'plain'
#   enable_starttls_auto: true
# }

