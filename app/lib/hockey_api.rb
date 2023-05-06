class HockeyApi
  include HTTParty
  base_uri 'https://statsapi.web.nhl.com'

  def initialize
  end

  def game_statuses
    self.class.get("/api/v1/gameStatus").to_a
  end

  def season(id = :current)
    self.class.get("/api/v1/seasons/#{id}").to_h['seasons'].first
  end

  def schedule(options = nil)
    path = '/api/v1/schedule'
    path += "?#{options.to_query}" if options.present?
    self.class.get(path).to_h
  end

  def boxscore(game_id)
    self.class.get("/api/v1/game/#{game_id}/boxscore").to_h
  end

  def linescore(game_id)
    self.class.get("/api/v1/game/#{game_id}/linescore").to_h
  end

  def live(game_id)
    self.class.get("/api/v1/game/#{game_id}/feed/live").to_h
  end
end
