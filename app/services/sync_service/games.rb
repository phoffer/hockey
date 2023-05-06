module SyncService
  class Games
    EXTERNAL_ID_FIELD = 'gamePk'

    def initialize(season, teams)
      @season = season
      @teams = teams
      @games = season.games.to_a
      @by_id = @games.index_by(&:external_id)
    end

    def get_game(data, date)
      @by_id[data[EXTERNAL_ID_FIELD]] || import_game(data, date)
    end

    private

    def import_game(data, date)
      attrs = extract_attributes(data).merge(date: date)
      game = @season.games.create(attrs)
      @games << game
      @by_id[game.external_id] = game
    end

    def extract_attributes(data)
      {
        external_id:  data[EXTERNAL_ID_FIELD],
        start_time:   data['gameDate'],
        status:       data.dig('status', 'statusCode').to_i,
        away_team:    @teams.get_team(data.dig('teams', 'away', 'team')),
        home_team:    @teams.get_team(data.dig('teams', 'home', 'team')),
      }
    end

  end
end
