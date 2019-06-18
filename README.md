# TexMindbody::Api

Thei gem is a wrapper for the v6 API from Mindbody. Currently it supports a very limited subset of calls

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tex_mindbody-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tex_mindbody-api

## Usage

```
TexMindbody::Api.configure do |config|
  config.username = "Siteowner"
  config.password = "apitest1234"
  config.api_key = "YOUR API KEY"
  config.site_id = "-99"
end

TexMindbody::Api.issue
clients = TexMindbody::Api.clients SearchText: "Smith"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/meka-nich/tex_mindbody-api.

