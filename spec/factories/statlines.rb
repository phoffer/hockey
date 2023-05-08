FactoryBot.define do
  factory :statline do
    player
    game
    stat_type { :skater }
    stats { {'skaterStats' => { "timeOnIce": "12:10", "assists": 2, "goals": 1 } } }

    trait :goalie do
      stat_type { :goalie }
      stats { {'goalieStats' => { "timeOnIce": "8:23", "shots": 12, "saves": 10 } } }
    end
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
