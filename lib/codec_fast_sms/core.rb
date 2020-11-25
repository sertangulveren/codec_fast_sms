# frozen_string_literal: true

module CodecFastSms
  # Core
  class Core
    attr_accessor :connection, :profile, :response, :to, :message, :attributes
    def initialize(profile: :default, attributes: {})
      self.profile = profile
      self.attributes = attributes
      # Firstly, create a connection object.
      self.connection = Faraday.new(
        url: ::CodecFastSms.configuration(profile).api_host
      )
    end

    # Call the api and process the response.
    def perform
      resp = connection.get(request_uri) do |req|
        req.params = params
      end
      self.response = resp.body
      # If server returns 200, everything is OK.
      true
    rescue Faraday::Error => e
      self.response = { message: e.message }
      false
    end

    def params; end
  end
end
