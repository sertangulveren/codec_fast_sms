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
        headerCode: '', responseType: '3', optionalParameters: ''
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
  end
end
