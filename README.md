# CodecFastSms [![Build Status](https://travis-ci.org/sertangulveren/codec_fast_sms.svg?branch=master)](https://travis-ci.org/sertangulveren/codec_fast_sms)

This client allows you to send sms using Codec Fast SMS API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codec_fast_sms'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install codec_fast_sms

## Configuration

Client must be configured before use. Configuration fields are as:

| Field           | Description                                                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------- |
| api_host        | Root url of the API.                                                                                    |
| username        | Your API username.                                                                                      |
| password        | Your API password.                                                                                      |
| sender          | Sms sender title.                                                                                       |

### Configuration on Rails Application:
Create a file in the `config/initializers` directory and configure client in this file as below:
`# config/initializers/codec_fast_sms.rb`
```ruby
CodecFastSms.configure do |config|
  config.api_host = 'https://fastsms.api.example.com'
  config.username = 'mysuperapiuser'
  config.password = 'mYsupeRsecreTqassworld'
  config.sender = 'MYSUPERCOMPANY'
end
```
### Multiple Configuration
You can define multiple configurations separated by profile. To do this, you must pass the profile parameter to the `configure` definition.
If the profile name is not pass in the configuration, it defaults to use `:default`.
##### Example:
In this example, to send sms , profile name specified as `settings`.
`# config/initializers/codec_otp_settings.rb`
```ruby
CodecFastSms.configure(:otp_user) do |config|
  config.api_host = 'https://fastsms.api.example.com'
  config.username = 'mysuperapiotpuser'
  config.password = 'mYsupeRsecreTqassworldforOtP'
  config.sender = 'MYSUPERCOMPANY'
end
```
## Usage
Initialize a client object before starting process.
```ruby
client = CodecFastSms::Client.new
```
To send sms, call the method `deliver`.
```ruby
phone = '905991112233'
message = 'Dear Hayri Gülümser, your membership has been activated.'
client.deliver(phone, message)
puts client.response
```

We can pass the profile argument on client initialization to use different configuration.
```ruby
client = CodecFastSms::Client.new(profile: :dynamic_settings)
client.deliver(phone, message)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sertangulveren/codec_fast_sms.

