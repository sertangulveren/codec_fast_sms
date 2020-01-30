# frozen_string_literal: true

require 'faraday'
require 'codec_fast_sms/version'
require 'codec_fast_sms/configuration'
require 'codec_fast_sms/core'
require 'codec_fast_sms/client'
module CodecFastSms
  class Error < StandardError; end
  class ProfileNotFound < Error; end
  class InvalidExtension < Error; end
  class NoProfilesWereFound < Error; end
end
