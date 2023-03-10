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

## Getting Started.

You can see the help documentation by running the following command: `rails g yorchauth --help`. It's not necessary to do it but it'll give you some information about how you can use this gem.

1. Copy the ruby gem into your project, in the Gemfile and then run:

```bash
$ bundle install
```

2. Generate the User Authentication using this command:

```bash
$ rails g yorchauth user
```

It generates controllers, models, views, migration, routes and a short configuration for Sendgrid in the **config/environments/development.rb** file.

3. The Yorchauth gem uses two gems: **bcrypt** and **dot-env**. So you will need to install these gems. Run the next command:

```bash
$ bundle install
```

4. Add your SENDGRID Keys into the **.env** file generated. For example:

```
  - SENDGRID_EMAIL_VALID='myuser@email.com'
  - SENDGRID_API_KEY='ALL_YOUR_API_KEY'
```

5. Run the following command to create the users table:

```bash
$ rails db:migrate
```

6. And finally, each controller you have will inherit from **AuthenticateController**.

```ruby
class PagesController < AuthenticateController
    before_action :authenticate_user

    def index; end
  end
```

7. Don't forget to add your API Keys into your .gitignore file and enjoy!

## Contributing
Feel free to contribute to this ruby gem. Make sure you have cloned this repository in your local computer. This repository has permissions, so you'll need to open a pull request each time you commit new changes.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
