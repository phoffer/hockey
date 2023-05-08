FactoryBot.define do
  factory :game do
    sequence(:external_id)
    season
    away_team
    home_team
  end
end

# == Schema Information
#
# Table name: games
#
#  id           :bigint           not null, primary key
#  away_score   :integer          default(0)
#  date         :date
#  home_score   :integer          default(0)
#  start_time   :datetime
#  status       :integer
#  time_display :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  away_team_id :bigint           not null
#  external_id  :integer          not null
#  home_team_id :bigint           not null
#  season_id    :bigint           not null
#
# Indexes
#
#  index_games_on_away_team_id  (away_team_id)
#  index_games_on_date          (date)
#  index_games_on_external_id   (external_id) UNIQUE
#  index_games_on_home_team_id  (home_team_id)
#  index_games_on_season_id     (season_id)
#  index_games_on_status        (status)
#
# Foreign Keys
#
#  fk_rails_...  (away_team_id => teams.id)
#  fk_rails_...  (home_team_id => teams.id)
#  fk_rails_...  (season_id => seasons.id)
#
