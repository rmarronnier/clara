Mailjet.configure do |config|
  config.api_key = ENV['ARA_EMAIL_USER']
  config.secret_key = ENV['ARA_EMAIL_PWD']
  config.default_from = ENV['ARA_EMAIL_DESTINATION']
end
