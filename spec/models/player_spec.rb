require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { create(:player) }
  it "should have a valid factory" do
    assert player.valid?
  end

  it "should be invalid without an external_id" do
    player.external_id = nil
    refute player.valid?
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
