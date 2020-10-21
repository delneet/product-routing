[ruby-badge]: https://img.shields.io/badge/ruby-2.7.2-green

# Product Routing

![Ruby][ruby-badge]

## Prerequisites

To run this application you need some software installed.
Assuming you are running on a mac and using homebrew.

### Ruby

With your ruby version manager of choice (rbenv).

```bash
brew install rbenv
rbenv init
rbenv install 2.7.2
rbenv rehash
```

### Bundler
```bash
gem install bundler --no-document
```

### Node

```bash
brew install node
```

### Yarn

```bash
brew install yarn
```

### Database: Postgres

Easy mac install via [Postgres.app](https://postgresapp.com/downloads.html).
Be sure to [setup the cli](https://postgresapp.com/documentation/cli-tools.html) in your path.

### Setup Rails

```bash
bin/setup
```

## Running the application

```bash
bin/rails s -p 3000
```

* Add some products
* Add some criteria definitions
* Find a destination by entering a product reference

## Running tests

```bash
bin/rails db:migrate RAILS_ENV=test
bundle exec rspec
```
