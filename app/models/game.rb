class Game < ApplicationRecord
  belongs_to :season
  belongs_to :away_team, class_name: 'Team'
  belongs_to :home_team, class_name: 'Team'

  has_many :statlines

  scope :for_date, ->(date = Date.today) { where(date: date) }

  def complete?
    [5, 6, 7].include? self.status
  end
end

# == Schema Information
#
# Table name: games
#
#  id           :bigint           not null, primary key
#  date         :date
#  start_time   :datetime
#  status       :integer
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
