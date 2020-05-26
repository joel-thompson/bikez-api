# README

Ruby on Rails API for the frontend react app: https://github.com/joel-thompson/bikez

Runs on Heroku. When pushing to master make sure to run migrations manually (below).

## Start the server:
`rails s`

## Run specs
`bundle exec rspec`

## Run migrations on production
`heroku run rails db:migrate`
