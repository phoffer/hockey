class Statline < ApplicationRecord
  belongs_to :player, optional: true # this isn't actually optional, but this prevents Rails from querying each player before updating records. not-null is enforced at the DB
  belongs_to :game
end

# == Schema Information
#
# Table name: statlines
#
#  id         :bigint           not null, primary key
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
