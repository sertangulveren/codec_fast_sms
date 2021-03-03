# frozen_string_literal: true

module CodecFastSms
  # Client
  class Client < Core
    # Api endpoint.
    def request_uri
      '/Soap.asmx/SendSms'
    end

    def params
      {
        userName: current_config.username,
        password: current_config.password,
        sender: current_config.sender,
        phone: to, messageContent: message, msgSpecialId: '', isOtn: 'True',
        headerCode: '', responseType: '3',
        optionalParameters: generate_optional_parameters
      }.merge(iys_params)
    end

    def iys_params
      {
        iysMessageType: (attributes[:iys_message_type] || 'BILGILENDIRME'),
        iysRecipientType: attributes[:iys_recipient_type].to_s,
        iysBrandCode: attributes[:iys_brand_code].to_s
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
      return attr.to_json if attr.is_a?(Hash) && !attr.empty?

      attr.to_s
    end
  end
end
