# frozen_string_literal: true

module CodecFastSms
  # Client
  class Client < Core
    # Api endpoint.
    def request_uri
      '/FastApi.asmx/SendSms'
    end

    def params
      {
        userName: ::CodecFastSms.configuration(profile).username,
        password: ::CodecFastSms.configuration(profile).password,
        sender: ::CodecFastSms.configuration(profile).sender,
        phone: to, messageContent: message, msgSpecialId: '', isOtn: 'True',
        headerCode: '', responseType: '3',
        optionalParameters: generate_optional_parameters
      }
    end

    def assign_recipient_information(to, message)
      self.to = to
      self.message = message
    end

    def deliver(to, message)
      assign_recipient_information(to, message)
      perform
    end

    def generate_optional_parameters
      attr = attributes[:optionalParameters]
      return attr if attr.is_a?(Hash) && !attr.empty?

      ''
    end
  end
end
