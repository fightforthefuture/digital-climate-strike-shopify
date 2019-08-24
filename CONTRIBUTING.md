## Contributing to this repository

The shopify app consist of:

1. Backend powered by Ruby on Rails. It's in charge of creating the widget customization variables script, 
  and shopify script tags for each authenticated shop.
2. Shopify App engine for shop authentication.

## Requirements 

- Ruby. The project has been built on Ruby 2.6.1

NOTE: If you use docker, then everything is ready for you. You will just need to use `docker-compose` and voilà.

## Build Setup

### Development
#### Without Docker

```
# install dependencies
$ bundle install

# setup db
$ bundle exec rails db:setup

# start development server
$ bundle exec rails s
```

#### With Docker

```
# build the docker image
$ docker-compose build

# setup db
$ docker-compose run --rm backend bundle exec rails db:setup

# start development server
$ docker-compose up -d backend
```

### Production
PENDING

