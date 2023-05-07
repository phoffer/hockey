class Player < ApplicationRecord
  belongs_to :team

  has_many :statlines

  validates :external_id, :name, presence: true

  scope :for_game, ->(game) { where(team_id: [game.home_team_id, game.away_team_id]) }

  VALID_POSITIONS = %w[C LW RW D G].freeze

  def player_type
    skater? ? :skater : :goalie
  end

  def skater?
    VALID_POSITIONS.include?(position) && !goalie?
  end

  def goalie?
    position == 'G'
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
