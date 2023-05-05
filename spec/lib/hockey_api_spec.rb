describe HockeyApi do
  subject(:api) { described_class.new }

  it 'should request game status' do
    stub_for('game-statuses')
    data = api.game_statuses
    expect(data).to be_instance_of(Array)
    expect(data.size).to eq(9)
  end

  context 'schedule data' do
    it 'should request nightly game schedule' do
      stub_for('schedule-pregame')
      data = api.schedule
      expect(data).to be_instance_of(Hash)
      expect(data['totalItems']).to eq(2)
    end

    it 'should request season game schedule' do
      stub_for('schedule-season')
      data = api.schedule(season: '20212022')
      expect(data).to be_instance_of(Hash)
      expect(data['totalItems']).to eq(1507)
    end
  end

  context 'game data' do
    let(:game_id) { 2022030212 }

    it 'should request live feed data' do
      stub_for('game-live-inprogress')
      data = api.live(game_id)
      expect(data).to be_instance_of(Hash)
      expect(data['gamePk']).to eq(game_id)
      expect(data).to include('liveData')
    end

    it 'should request boxscore data' do
      stub_for('game-boxscore-inprogress')
      data = api.boxscore(game_id)
      expect(data).to be_instance_of(Hash)
      expect(data).to include('teams')
    end

    it 'should request linescore data' do
      stub_for('game-linescore-inprogress')
      data = api.linescore(game_id)
      expect(data).to be_instance_of(Hash)
      expect(data).to include('periods')
    end
  end

end
