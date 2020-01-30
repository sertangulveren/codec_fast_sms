# frozen_string_literal: true

require_relative 'lib/codec_fast_sms/version'

Gem::Specification.new do |spec|
  spec.name          = 'codec_fast_sms'
  spec.version       = CodecFastSms::VERSION
  spec.authors       = ['Sertan Gülveren']
  spec.email         = ['sertangulveren@gmail.com']

  spec.summary       = 'Codec FastSMS Library for Ruby.'
  spec.description   = 'It is a simple ruby client for Codec FastSMS API.'
  spec.homepage      = 'https://github.com/sertangulveren/codec_fast_sms'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.require_paths = ['lib']
  spec.add_development_dependency('minitest', '~> 5.0')
  spec.add_development_dependency('rake', '~> 12.0')
  spec.add_development_dependency('rubocop', '~> 0.79.0')
  spec.add_development_dependency('simplecov', '~> 0.17.1')
  spec.add_development_dependency('webmock', '~> 3.8')

  spec.add_dependency('faraday', '~> 0.11.0')
end
