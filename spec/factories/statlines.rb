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
# Table name: players
#
#  id          :bigint           not null, primary key
#  jersey      :integer
#  name        :string
#  position    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer
#  team_id     :bigint           not null
#
# Indexes
#
#  index_players_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
