require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # Filter out auth tokens from VCR cassettes
  config.filter_sensitive_data('<AUTH_TOKEN>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end
end
