# README

## How to run

Assuming you've already set everything up, everything can be run with the following command:

```
bin/dev
```

This will boot the server on port 3000 and also run the clockwork process to sync schedule and live games.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Local setup

#### Requirements

* Postgres
* Some kind of version manager to provide:
  - Ruby 3.2.0
  - Yarn
  - Node

#### Setup

```
git clone

# if ruby/nodejs/yarn aren't available via asdf
asdf plugin add ruby
asdf plugin add nodejs
asdf plugin add yarn
# 

asdf install
bundle
yarn
bundle exec rails db:setup

```

# Considerations for a larger system but not handled for this app

* Building for different sports
  - Add a models for sports and for leagues
  - seasons, teams belong_to(:league)
  - configure which leagues utilize which API wrappers
* Proper team/player sync
  - There is a decent amount of complexity around team/player syncing in sports
  - For example, players have a not-null constraint on team_id. This isn't accurate in real life (free agents, retired)
  - Teams can move, change names, etc, so need extra data to associate that to seasons
  - Teams are treated as static entities here
  - We will use lazy evaluation to set up team/players for this
  - Teams loaded from schedule, players loaded from game stats
* Request queueing and concurrency for realtime data sync
  - consecutive requests works right now when there's 1-2 games at a time
  - For a serious system, this should make concurrent requests, ie. using Typheous
  - Only checking active games instead of all games today
