# README

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
  - see notes in code
