module SyncService
  class GameStats
    attr_reader :game
    def initialize(game)
      @game = game
    end

    def sync(live_data = nil)
      @statlines = game.statlines.reload.index_by(&:player_id)
      @players = Player.for_game(game).index_by(&:external_id)
      return if game.complete? && @statlines.present?
      live_data ||= live
      team_data = live_data.dig('liveData', 'boxscore', 'teams')
      status = live_data.dig('gameData', 'status', 'statusCode')
      game.assign_attributes(game_status(live_data))
      ApplicationRecord.transaction do
        if game.inprogress? || game.complete?
          update_statlines(team_data.dig('away', 'players'), game.away_team)
          update_statlines(team_data.dig('home', 'players'), game.home_team)
        end
        game.save
      end
    end

    private

    def game_status(live_data)
      {
        status:       live_data.dig('gameData', 'status', 'statusCode'),
        home_score:   live_data.dig('liveData', 'linescore', 'teams', 'home', 'goals'),
        away_score:   live_data.dig('liveData', 'linescore', 'teams', 'away', 'goals'),
        time_display: time_display(live_data.dig('liveData', 'linescore')),
      }
    end

    def time_display(linescore)
      # there is more complexity than covered here, just don't know full range of data returned
      # ie. end of 1st, 1st intermission, start of 2nd, shootout (regular season), OT numbering (playoffs)
      time = linescore['currentPeriodTimeRemaining']
      period = linescore['currentPeriodOrdinal']
      if time == 'Final'
        'Final' # this misses the standard display if a game went to overtime => Final (OT)
      elsif time && period
        [time, period].join(' ')
      elsif time == '0:00'
        "End #{period}"
      end
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
      statline.update(stats: player_data.dig('stats'), stat_type: player.player_type)
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

    def live
      api.live(game.external_id)
    end

  end
end
