# README

## How to run

Assuming you've already set everything up, everything can be run with the following command:

```
bin/dev
```

This will boot the server on port 3000 and also run the clockwork process to sync schedule and live games.

Visit https://localhost:3000 and have fun!

## Local setup

Local setup will import the current hockey season, but not sync any game data. Games for the current league date (ie. date for NHL) will automatically sync when running server. Other games can be manually synced from the schedule page.

To import additional season, open a Rails console and run `SyncService::Seasons.import('SEASON_ID')`, where season ID follows the pattern of combining start and end years. IE. for 2021-2022, the ID is `20212022`.

### Requirements

* Postgres
* Some kind of version manager to provide:
  - Ruby 3.2.0
  - Yarn
  - Node

### Setup

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
bin/dev
```

## Considerations for a larger system but not handled for this app

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

## Bugs

* Some temporary condition that allows stats to be created for players not playing in game. Suspect it's pregame data
* Manual game update is handled in http request cycle. This is to avoid adding more requirements (redis/sidekiq) to this for now.

## TODO

* smarter logic to select which games to update, instead of all for current date
* Update controller/views for players to have game log
* Update controller/views for teams to have game schedule
* Auto update games live! Add some hotwire/stimulus fun
