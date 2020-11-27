# frozen_string_literal: true

require 'test_helper'
module CodecFastSms
  class ClientTest < Minitest::Test
    def setup
      configure_default_profile
      @client = ::CodecFastSms::Client.new

      # For use perform method.
      @client.assign_recipient_information('905990000000', 'Hello Recipient!')

      # For use deliver method.
      @params_to_use_deliver = @client.params
      @params_to_use_deliver[:phone] = '901234567890'
      @params_to_use_deliver[:messageContent] = 'Hello Sertan!'
    end

    def test_delivery_must_be_successful
      generate_stub_for_perform

      assert @client.perform
    end

    def test_delivery_must_be_successful_via_deliver_method
      generate_stub_for_deliver
      assert @client.deliver(@params_to_use_deliver[:phone],
                             @params_to_use_deliver[:messageContent])

      # Message and phone must be equal that assigned on deliver.
      assert_equal @params_to_use_deliver[:phone], @client.params[:phone]
      assert_equal @params_to_use_deliver[:messageContent],
                   @client.params[:messageContent]
    end

    def test_message_and_phone_must_be_correct
      # Message and phone must be equal that assigned on setup.
      assert_equal '905990000000', @client.params[:phone]
      assert_equal 'Hello Recipient!', @client.params[:messageContent]
    end

    def test_optional_parameters_must_be_blank
      assert_equal '', @client.params[:optionalParameters]
    end

    def test_permission_filter_must_be_disabled
      @client = ::CodecFastSms::Client.new(attributes:
                                               permission_filter_disabled)

      # For use perform method.
      @client.assign_recipient_information('905990000000', 'Hello Recipient!')

      assert_equal '{"DisablePermissionFilter":true}',
                   @client.params[:optionalParameters]
    end

    def test_otp_user_profile_must_be_run_successfully
      configure_otp_user
      @client = ::CodecFastSms::Client.new(profile: :otp_user)
      generate_stub_for_perform(:otp_user)

      assert @client.perform
    end

    def test_request_must_be_time_out
      generate_timeout_stub_for_perform
      # Must be return false
      refute @client.perform
    end

    def test_timeout_exception_message_must_be_handled
      generate_timeout_stub_for_perform
      refute @client.perform

      # Message must be timeout message.
      assert_equal 'execution expired', @client.response[:message]
    end

    private

    def generate_stub_for_deliver
      genarete_request_stub_for(::CodecFastSms.configuration.api_host,
                                @client.request_uri, @params_to_use_deliver)
    end

    def generate_stub_for_perform(profile = :default)
      genarete_request_stub_for(
        ::CodecFastSms.configuration(profile).api_host,
        @client.request_uri, @client.params
      )
    end

    def generate_timeout_stub_for_perform
      genarete_timeout_stub_for(::CodecFastSms.configuration.api_host,
                                @client.request_uri, @client.params)
    end

    def permission_filter_disabled
      { optionalParameters: { DisablePermissionFilter: true } }
    end
  end
end
