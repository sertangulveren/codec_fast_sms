# frozen_string_literal: true

require 'test_helper'
module CodecFastSms
  class CoreTest < Minitest::Test
    def setup
      configure_default_profile
      @core_object = ::CodecFastSms::Core.new
    end

    def test_an_error_must_occur_if_profile_not_defined
      # We configured without specify a profile on setup
      # If the profile is not specified in the configuration,
      # the default profile name will be called :default
      # :settings not defined
      assert_raises CodecFastSms::ProfileNotFound do
        ::CodecFastSms::Core.new(profile: :settings)
      end
    end

    def test_core_class_should_be_initialized
      # The Core class should be able to initialize on its own.
      assert ::CodecFastSms::Core.new(profile: :default)
      # default profile is :default.
      assert ::CodecFastSms::Core.new
    end
  end
end
