module SyncService
  class GameStats
    def initialize(game_id)
      @game_id = game_id
    end

    def api
      @api ||= HockeyApi.new
    end

    def sync

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
