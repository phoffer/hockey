FactoryBot.define do
  factory :player do
    sequence(:external_id)
    team
    name { FFaker::Name.name }
    jersey { rand(98) + 1 } # NHL doesn't allow 0 and 99 is permanently retired
    position { Player::VALID_POSITIONS.sample }
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
