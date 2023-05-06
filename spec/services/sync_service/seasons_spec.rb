describe SyncService::Seasons do
  subject(:service) { described_class.new(season_id) }
  let(:season_id) { '20222023' }

  it 'should import season overview' do
    stub_for('season')
    expect { data = service.sync }.to change(Season, :count).by(1)
    expect(Season.first.external_id).to eq(season_id)
  end

  context 'import schedule data' do
    let(:season_id) { '20212022' }
    subject(:service) { described_class.new(create(:season, external_id: season_id))}

    context 'full season' do
      before { stub_for('schedule-season') }

      it 'should import all games' do
        expect { service.sync_schedule }.to change(Game, :count).by(1507)
      end
      it 'should import all teams' do
        expect { service.sync_schedule }.to change(Team, :count).by(36)
      end
    end
    context 'should import today' do
      before { stub_for('schedule-pregame') }

      it 'should import all games' do
        expect { service.sync_today }.to change(Game, :count).by(2)
      end
      it 'should import all teams' do
        expect { service.sync_today }.to change(Team, :count).by(4)
      end
    end
  end
end
