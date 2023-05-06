module SyncService
  class GameStats
    attr_reader :game
    def initialize(game)
      @game = game
      @statlines = game.statlines.index_by(&:player_id)
      if @statlines.empty?
        @players = Player.for_game(game).index_by(&:external_id)
      end
    end

    def sync
      live_data = api.live(game.external_id)
      update_statlines(live_data.dig('liveData', 'boxscore', 'teams', 'away', 'players'), game.away_team)
      update_statlines(live_data.dig('liveData', 'boxscore', 'teams', 'home', 'players'), game.home_team)
    end

    def update_statlines(players, team)
      return if players.blank? # not sure all possible data structuring, this catches if data isn't available or is empty
      players.each_value do |player_data|
        update_player_stats(player_data, team)
      end
    end

    def update_player_stats(player_data, team)
      player_external_id = player_data.dig('person', 'id')
      return if player_data.dig('position', 'code') == 'N/A' # game scratch, or backup goalie without appearance
      player = @players[player_external_id] || create_player(player_data, team)
      unless statline = @statlines[player.id]
        statline = @statlines[player.id] || player.statlines.new(game: game)
      end
      statline.update(stats: player_data.dig('stats'))
    end

    def create_player(player_data, team)
      player = team.players.create(extract_player_attributes(player_data))
      @players[player.external_id] = player
    end

    def extract_player_attributes(player_data)
      {
        external_id: player_data.dig('person', 'id'),
        name:        player_data.dig('person', 'fullName'),
        jersey:      player_data.dig('jerseyNumber'),
        position:    player_data.dig('position', 'abbreviation'),
      }
    end

    def api
      @api ||= HockeyApi.new
    end

    def linescore
      @linescore ||= api.linescore(@game_id)
    end

    def boxscore
      @boxscore ||= api.boxscore(@game_id)
    end

    def live
      @live ||= api.live(@game_id)
    end

  end
end
