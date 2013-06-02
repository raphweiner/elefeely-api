# Load the rails application
require File.expand_path('../application', __FILE__)

ElefeelyApi::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 => 587,
    :domain               => 'baci.lindsaar.net',
    :user_name            => 'elefeely@gmail.com',
    :password             => ENV['GMAIL_PASS'],
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
end

# Initialize the rails application
ElefeelyApi::Application.initialize!
