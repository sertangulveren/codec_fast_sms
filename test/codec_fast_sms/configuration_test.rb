# frozen_string_literal: true

require 'test_helper'
module CodecFastSms
  class ConfigurationTest < Minitest::Test
    def setup
      configure_default_profile # defined in test_helper.rb
    end

    def test_config_root_url_must_be_correct
      assert_equal 'https://fastsms.api.example.com',
                   ::CodecFastSms.configuration.api_host
    end

    def test_config_password_must_be_correct
      assert_equal TEST_PASSWORD, ::CodecFastSms.configuration.password
    end

    def test_config_sender_must_be_correct
      assert_equal 'MYSUPERCOMPANY', ::CodecFastSms.configuration.sender
    end

    def test_config_profile_must_be_correct
      # We didn't specified the profile name in configuration.
      # Therefore, the profile name must be :default.
      assert_equal :default, ::CodecFastSms.configuration.profile
    end

    def test_an_error_must_occur_if_profile_not_defined
      # We configured without specify a profile on setup
      # If the profile is not specified in the configuration,
      # the default profile name will be called :default
      # :translation_repo not defined
      assert_raises ::CodecFastSms::ProfileNotFound do
        ::CodecFastSms.configuration(:translation_repo)
      end
    end

    def test_if_profile_is_defined_there_must_be_no_errors
      assert ::CodecFastSms.configuration(:default)
      # if not specified, uses :default
      assert ::CodecFastSms.configuration
    end
  end
end
