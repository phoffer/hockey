FactoryBot.define do
  factory :team, aliases: [:away_team, :home_team] do
    sequence(:external_id)
  end
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
