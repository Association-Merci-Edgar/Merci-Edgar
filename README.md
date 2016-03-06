# Edgar

[![Join the chat at https://gitter.im/Association-Merci-Edgar/Merci-Edgar](https://badges.gitter.im/Association-Merci-Edgar/Merci-Edgar.svg)](https://gitter.im/Association-Merci-Edgar/Merci-Edgar?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/Association-Merci-Edgar/Merci-Edgar.png?branch=wip)](https://travis-ci.org/Association-Merci-Edgar/Merci-Edgar)
[![Code Climate](https://codeclimate.com/github/Association-Merci-Edgar/Merci-Edgar.png)](https://codeclimate.com/github/Association-Merci-Edgar/Merci-Edgar)


Merci Edgar is a CRM dedicated to artists (musicians, actors...)


## Ruby on Rails

This application requires:

* Ruby version 2.0
* Rails version 3.2.13

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).


## Development

* Template Engine: Haml
* Front-end Framework: Twitter Bootstrap (Sass)
* Form Builder: SimpleForm
* Authentication: Devise
* Background processing : Sidekiq

### Docker usage

* `docker-compose up` to start server
* `docker-compose run webapp rspec` to run test with rspec
* `docker-compose run webapp rake [command]` to run rake command
* `docker-compose run webapp rails [command]` to run rails command

You need to have [`docker-compose`
installed](http://docs.docker.com/compose/install/) on your machine :-).


## Email

The application is configured to send email using a Mandrill account.

## Getting Started

1. Copy .env.example to .env and customize it with your credentials for:
  * amazon S3
  * mandrill
  * mailchimp
  * [rollbar (for production)](https://rollbar.com/krichtof/Merci-Edgar/)
  * stripe

2. Create the postgresql user and dev database both named  `merciedgar`
If you are on ArchLinux you will [find some help here](https://wiki.archlinux.org/index.php/PostgreSQL).

3. Install dependencies with `bundle install` and run migrations with `rake db:migrate`

If you meet an error installing the gem 'capybara-webkit', [try this solution, depending on your OS](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit).

4. Open 3 different terminals and launch
  * a [redis](http://redis.io/topics/quickstart server with `redis-server`)
  * a [sidekiq](http://sidekiq.org/) worker with : `bundle exec sidekiq`
  * `rails server`

Open a browser on [http://www.lvh.me:3000](http://www.lvh.me:3000)

## Documentation and Support

This is the only documentation.
More documentation will come soon.

To generate db Schema, you can use ERD:

`bundle exec erd --inheritance --direct --attributes=foreign_keys,content`

## Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

## Credits

See CREDITS.txt file

## License

See LICENSE.txt file
