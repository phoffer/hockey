class Statline < ApplicationRecord
  belongs_to :player, optional: true # this isn't actually optional, but this prevents Rails from querying each player before updating records. not-null is enforced at the DB
  belongs_to :game

  enum stat_type: {
    skater: 1,
    goalie: 2,
  }

  DISPLAYED_STATS = {
    'TOI' => 'timeOnIce',
    'G'   => 'goals',
    'A'   => 'assists',
    'P'   => 'points',
    '+/-' => 'plusMinus',
    'S'   => 'shots',
    'H'   => 'hits',
    'PIM' => 'penaltyMinutes',
  }

  def stat(stat_name)
    if stat_name == 'points'
      data['goals'] + data['assists']
    else
      data[stat_name]
    end
  end

  private

  def data
    skater? ? skater_stats : goalie_stats
  end

  def skater_stats
    stats['skaterStats'] || {}
  end

  def goalie_stats
    stats['goalieStats'] || {}
  end
end

# == Schema Information
#
# Table name: statlines
#
#  id         :bigint           not null, primary key
#  stat_type  :integer
#  stats      :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :bigint           not null
#  player_id  :bigint           not null
#
# Indexes
#
#  index_statlines_on_game_id    (game_id)
#  index_statlines_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (player_id => players.id)
#
