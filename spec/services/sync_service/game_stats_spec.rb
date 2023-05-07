describe SyncService::GameStats do
  subject(:service) { described_class.new(game) }
  let(:game) { create(:game, external_id: game_id, status: 0) }
  let(:game_id) { '2022030212' }

  it 'should sync' do
    stub_for('game-live-inprogress')
    expect { service.sync }.to change(Statline, :count).by(40)
  end

end
