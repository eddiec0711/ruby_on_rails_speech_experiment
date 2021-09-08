Airbrake.configure do |config|
  config.api_key = '45d19e8a7577f6c60365a3a92412e7a4'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end