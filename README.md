# README

This app is a GraphQL API for Restaurant Menu.

I logged my work notes [here](docs/worklog.md)

Access the GraphiQL interface via: https://resto-menu-api-3c61fad65343.herokuapp.com/graphiql

You can check [GraphQL Fixtures](spec/fixtures/graphql) for some sample queries


## Pre-requisites

### Ruby version
```
cat .ruby-version
> 3.3.1
```

Run the following if you do not have this version:

```
brew upgrade ruby-build
rbenv install 3.3.1
```

### Database

Running locally requires `sqlite`

## Setup

### Installing gems

```
bundle install
```

### DB setup
```
bundle exec rails db:setup db:migrate db:seed
```

## Running the server

```
bundle exec rails server
```

Application is available at `localhost:3000`

### Endpoints

- `POST /graphql`: the main graphql endpoint
- `GET /graphiql`: provides an interface to craete a request

**NOTE**: Ideally, the `/graphiql` endpoint is not accessible in prod. However, since we are just using dummy data, this endpoint is exposed for easier testing.

## Testing

This application uses RSpec for testing.

In addition, factory helpers like `factory_bot` and `faker` were used to generate dummy data for test.

Run the tests via:

```
bundle exec rspec
```
