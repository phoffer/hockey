require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create(:game) }
  it "should have a valid factory" do
    assert game.valid?
  end

  it "should be invalid without an external_id" do
    game.external_id = nil
    refute game.valid?
  end

  describe '#title' do
    it 'should display game title' do
      expect(game.title).to include(game.home_team.name)
      expect(game.title).to include(game.away_team.name)
    end
  end

  context 'game status helpers' do
    it 'should identify completed games' do
      refute game.complete?
      game.status = 7 # hate magic numbers, see fixtures/game_statuses.json
      assert game.complete?
    end
    it 'should identify in progress games' do
      refute game.inprogress?
      game.status = 3 # hate magic numbers, see fixtures/game_statuses.json
      assert game.inprogress?
    end
  end

  it 'should sync' do
    stub_for('game-live-inprogress')
    game = create(:game, external_id: '2022030212', status: 0)
    expect { game.sync_live }.to change(Statline, :count).by(40)
  end

end

# == Schema Information
#
# Table name: games
#
#  id           :bigint           not null, primary key
#  away_score   :integer          default(0)
#  date         :date
#  home_score   :integer          default(0)
#  start_time   :datetime
#  status       :integer
#  time_display :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  away_team_id :bigint           not null
#  external_id  :integer          not null
#  home_team_id :bigint           not null
#  season_id    :bigint           not null
#
# Indexes
#
#  index_games_on_away_team_id  (away_team_id)
#  index_games_on_date          (date)
#  index_games_on_external_id   (external_id) UNIQUE
#  index_games_on_home_team_id  (home_team_id)
#  index_games_on_season_id     (season_id)
#  index_games_on_status        (status)
#
# Foreign Keys
#
#  fk_rails_...  (away_team_id => teams.id)
#  fk_rails_...  (home_team_id => teams.id)
#  fk_rails_...  (season_id => seasons.id)
#
