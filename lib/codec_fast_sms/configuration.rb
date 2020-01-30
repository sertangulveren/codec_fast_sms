# frozen_string_literal: true

# main module
module CodecFastSms
  class << self
    attr_accessor :configurations

    def configuration(profile = :default)
      raise NoProfilesWereFound if configurations.nil? || configurations.empty?

      configurations.select do |conf|
        conf.profile == profile
      end.first || raise(ProfileNotFound, "Undefined profile: #{profile}")
    end

    private

    def reject_profile(profile)
      configurations.reject! { |conf| conf.profile == profile }
    end

    def initialize_configuration
      self.configurations = [] if configurations.nil?
      Configuration.new
    end

    def after_configuration_events(conf, profile)
      conf.profile = profile # FORCE!
      reject_profile(profile)
      configurations << conf
    end
  end

  def self.configure(profile = :default)
    conf = initialize_configuration
    yield(conf)
    after_configuration_events(conf, profile)
  end

  # Configuration class
  class Configuration
    EXTENSION_TYPES = %w[yml json].freeze

    attr_accessor :profile, :api_host, :username, :password, :sender

    def initialize
      self.profile = :default
    end
  end
end
