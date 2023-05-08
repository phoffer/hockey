class GamesController < ApplicationController
  before_action :set_game, only: %i[ show sync ]

  # GET /games or /games.json
  def index
    @date = (params[:date] || Hockey.current_league_date).to_date
    @games = Game.for_date(@date)
  end

  # GET /games/1 or /games/1.json
  def show
    @game.load_stats
  end

  def sync
    @game.sync_live
    redirect_back fallback_location: game_path(@game)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Uncomment if editing capabilities are added
    # def game_params
    #   params.require(:game).permit(:external_id, :season_id, :status, :date, :start_time, :away_team_id, :home_team_id)
    # end
end
