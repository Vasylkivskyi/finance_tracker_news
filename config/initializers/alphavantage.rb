require 'alphavantage'

Alphavantage.configure do |config|
  config.api_key = Rails.application.credentials.alpha_vantage[:access_key]
end
