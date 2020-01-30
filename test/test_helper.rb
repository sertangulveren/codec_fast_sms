# frozen_string_literal: true

require 'simplecov'
require 'webmock/minitest'

SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

TEST_PASSWORD = 'yes.thisismytopsecretpassword'
require 'codec_fast_sms'

require 'minitest/autorun'

# Create a default configuration for tests.
def configure_default_profile
  # Default profile is :default.
  # We can create another configuration like:
  # ::CodecFastSms.configure(:settings)
  ::CodecFastSms.configure do |config|
    config.api_host = 'https://fastsms.api.example.com'
    config.username = 'codecuser'
    config.password = TEST_PASSWORD # defined in test_helper.rb
    config.sender = 'MYSUPERCOMPANY'
  end
end

# Example profile name for compiled version: :otp_user
def configure_otp_user
  ::CodecFastSms.configure(:otp_user) do |config|
    config.api_host = 'https://fastsms.api.example.com'
    config.username = 'codecuser_otp'
    config.password = TEST_PASSWORD # defined in test_helper.rb
    config.sender = 'MYSUPERCOMPANY'
  end
end

# Standard response data for tests
def standard_mock_data
  '<?xml version="1.0" encoding="utf-8"?>
  <string xmlns="http://tempuri.org/">
  {
    "ResultSet": { "Code": 0, "Description": "OK" },
    "ResultList": [
      { "SmsRefId": "1234567890", "Status": 2, "ErrorCode": 0 }
    ]
  }
  </string>'
end

# Definition generates responses for api calls.
def genarete_request_stub_for(root_url, req_uri, params)
  stub_request(:get, "#{root_url}#{req_uri}").with(
    query: hash_including(Hash[params.collect { |k, v| [k.to_s, v] }])
  ).to_return(
    status: 200,
    body: standard_mock_data.to_json,
    headers: { 'Content-Type' => 'application/json' }
  )
end

# Definition generates timeouts for api calls.
def genarete_timeout_stub_for(root_url, req_uri, params)
  stub_request(:any, "#{root_url}#{req_uri}").with(
    query: hash_including(Hash[params.collect { |k, v| [k.to_s, v] }])
  ).to_timeout
end
