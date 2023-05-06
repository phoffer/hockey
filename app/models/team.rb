class Team < ApplicationRecord
  has_many :away_games, class_name: 'Game', foreign_key: :away_team_id
  has_many :home_games, class_name: 'Game', foreign_key: :home_team_id
end

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :integer          not null
#
# Indexes
#
#  index_teams_on_external_id  (external_id) UNIQUE
#
