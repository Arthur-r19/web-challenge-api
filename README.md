# Web Coding Challenge [API]
API for schedule and manage lectures for a event. After this server setup checkout the complementary project that consumes this api on: [Web Coding Challenge [Frontend]](https://github.com/Arthur-r19/web-challenge-frontend/tree/develop)

## Prerequisites
- Ruby 3.1.2
- Rails 6.1.7
- PostgreSQL 12.12

## Gems
#### Development
- [Active model serializers](https://github.com/rails-api/active_model_serializers)

#### Testing
- [Rspec](https://github.com/rspec/rspec-rails)
- [Shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- [Factory-bot](https://github.com/thoughtbot/factory_bot_rails)
- [Faker](https://github.com/faker-ruby/faker)

## Setup
### 1. Clone this repository
```
git clone git@github.com:Arthur-r19/web-challenge-api.git
```
### 2. Configure database.yml file
Set your username and password.
### 3. Install dependencies
```
bundle install
```
### 4. Setup database
```
rails db:create
rails db:migrate
```
### 5. Start server
```
rails s
```
Server will be listening on [http:/localhost:3000/](http:/localhost:3000/)
