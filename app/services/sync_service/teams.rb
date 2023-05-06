module SyncService
  class Teams
    EXTERNAL_ID_FIELD = 'id'

    def initialize
      @teams = Team.all.to_a
      @by_id = @teams.index_by(&:external_id)
    end

    def get_team(data)
      @by_id[data[EXTERNAL_ID_FIELD]] || import_team(data)
    end

    private

    def import_team(data)
      attrs = extract_attributes(data)
      team = Team.create(attrs)
      @teams << team
      @by_id[team.external_id] = team
    end

    def extract_attributes(data)
      {
        external_id:  data[EXTERNAL_ID_FIELD],
        name:         data['name'],
      }
    end

  end
end
