require 'rails_helper'

RSpec.describe Statline, type: :model do
  let(:statline) { create(:statline) }
  it "should have a valid factory" do
    assert statline.valid?
  end

  describe '#stats' do
    it 'should return regular stats' do
      expect(statline.stat(:goals)).to   eq 1
      expect(statline.stat(:assists)).to eq 2
    end
    it 'should return points' do
      expect(statline.stat(:points)).to eq 3
    end
    it 'should return regular goalie stats' do
      statline = create(:statline, :goalie)
      expect(statline.stat(:saves)).to eq 10
      expect(statline.stat(:shots)).to eq 12
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
