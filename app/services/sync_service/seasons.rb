module SyncService
  class Seasons
    EXTERNAL_ID_FIELD = 'seasonId'

    def initialize(season = :current)
      if season.is_a?(Season)
        @season_id  = season.external_id
        @season     = season
      else
        @season_id = season
      end
    end

    def sync_schedule
      load_schedule(true)
      sync_games
    end

    def sync_today
      load_schedule(false)
      sync_games
    end

    def sync
      if @season_id == :current
        @season_id = info[EXTERNAL_ID_FIELD]
      end
      season
    end

    private

    def api
      @api ||= HockeyApi.new
    end

    def season
      @season ||= begin
        data = extract_attributes(info)
        season = Season.find_or_create_by(external_id: data[:external_id])
        season.update(data)
        season
      end
    end

    def sync_games
      @games = SyncService::Games.new(season, SyncService::Teams.new)
      @season_games = season.games.index_by(&:external_id)
      schedule['dates'].map do |daily_schedule|
        sync_date(daily_schedule)
      end
    end

    def sync_date(daily_schedule)
      date = daily_schedule['date'] # schedule does not have TZ data, so this gets us the local/league game date
      daily_schedule['games'].map do |game_data|
        sync_game(game_data, date)
      end
    end


    def sync_game(game_data, date)
      @games.get_game(game_data, date)
    end

    def info
      @info ||= api.season(@season_id)
    end

    def load_schedule(full = false)
      @schedule = full ? api.schedule(season: @season_id) : api.schedule
    end

    def schedule
      @schedule ||= load_schedule
    end

    def today
      @today ||= api.schedule
    end

    def extract_attributes(data)
      {
        external_id:        data[EXTERNAL_ID_FIELD],
        regular_start_date: data['regularSeasonStartDate'],
        regular_end_date:   data['regularSeasonEndDate'],
        end_date:           data['seasonEndDate'],
      }
    end

    def self.sync(season_id = :current)
      self.new(season_id).sync
    end

    def self.import(season_id = :current)
      service = self.new(season_id)
      service.sync
      service.sync_schedule
    end
  end
end
