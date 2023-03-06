# Yorchauth - Ruby Gem
The yorchauth gem allows you to configure a user authentication uing bcrypt and sendgrid as the default SMTP protocol.

If you want to build a user authentication rapidly and send email confirmations to any email account, the yorchauth gem will help you. It generates controllers (authenticate, users and sessions), mailers, model, views, routes and migrations.

Besides, it adds the Sendgrid Configuration in the config/development.rb file. You just need to create the env file and your API KYES from Sendgrid

## Installation
Add the yorchauth gem in your Gemfile.

```ruby
gem "yorchauth", github: 'Jorge-Ortiz-Mata/yorchauth-ruby-gem'
```

And then execute:
```bash
$ bundle install
```

## Contributing
Feel free to contribute to this ruby gem. Make sure you have cloned this repository in your local computer. This repository has permissions, so you'll need to open a pull request each time you commit new changes.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
