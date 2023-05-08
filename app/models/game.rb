class Game < ApplicationRecord
  belongs_to :season
  belongs_to :away_team, class_name: 'Team'
  belongs_to :home_team, class_name: 'Team'

  has_many :statlines, dependent: :destroy

  validates :external_id, presence: true

  scope :for_date, ->(date = nil) { where(date: date || Hockey.current_league_date).includes(:home_team, :away_team) } # do it this way to allow passing nil, ie. `Game.for_date(params[:date])`


  attr_reader :home_stats, :away_stats

  def title
    [away_team.name, home_team.name].join(' @ ')
  end

  # hardcoding for now :( see `game-statuses.json` for more info
  def inprogress?
    [3, 4].include? self.status
  end

  def complete?
    [5, 6, 7].include? self.status
  end

  def load_stats
    @home_stats, @away_stats = statlines.includes(:player).sort_by { |stats| stats.player.jersey }.partition { |stats| stats.player.team_id == self.home_team_id }
  end

  def sync_live
    sync_service.sync
  end

  def sync_service
    SyncService::GameStats.new(self)
  end

  def live_url
    HockeyApi.live_url(self.external_id)
  end

  def self.sync_live_games
    for_date.each(&:sync_live)
  end

  def self.import_daily_schedule
    SyncService::Seasons.new.sync_today
  end

  # this allows for concurrent game updates
  # this is not really important when there's only 1 or 2 games at the same time
  # but this is important for a bigger system, or for when there's multiple games simultaneously
  # important for recurring job timing and also error handling (one game request failing won't block others)
  def self.concurrent_sync(date = nil)
    games = for_date(date) # this will allow testing with days with multiple games
    requests = games.map do |game|
      [game.live_url, game.sync_service.method(:sync)]
    end
    hydra = Typhoeus::Hydra.new(max_concurrency: 20)
    requests.each do |url, callback|
      request = Typhoeus::Request.new(url, method: :get)
      request.on_complete do |response|
        begin
          res = JSON.parse(response.body)
          callback.call(res)
        rescue JSON::ParserError => e
          #
        rescue => e
          #
        end
      end
      hydra.queue request
    end
    hydra.run
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
