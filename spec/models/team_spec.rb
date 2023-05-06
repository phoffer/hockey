require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { create(:team) }
  it "should have a valid factory" do
    assert team.valid?
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
