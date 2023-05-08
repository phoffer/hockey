# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_08_194513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "external_id", null: false
    t.bigint "season_id", null: false
    t.integer "status"
    t.date "date"
    t.datetime "start_time"
    t.bigint "away_team_id", null: false
    t.bigint "home_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_score", default: 0
    t.integer "away_score", default: 0
    t.string "time_display"
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["date"], name: "index_games_on_date"
    t.index ["external_id"], name: "index_games_on_external_id", unique: true
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
    t.index ["season_id"], name: "index_games_on_season_id"
    t.index ["status"], name: "index_games_on_status"
  end

  create_table "players", force: :cascade do |t|
    t.integer "external_id"
    t.bigint "team_id", null: false
    t.string "name"
    t.integer "jersey"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "external_id", null: false
    t.date "regular_start_date"
    t.date "regular_end_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_seasons_on_external_id", unique: true
  end

  create_table "statlines", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "game_id", null: false
    t.json "stats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stat_type"
    t.index ["game_id"], name: "index_statlines_on_game_id"
    t.index ["player_id"], name: "index_statlines_on_player_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "external_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_teams_on_external_id", unique: true
  end

  add_foreign_key "games", "seasons"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "players", "teams"
  add_foreign_key "statlines", "games"
  add_foreign_key "statlines", "players"
end
