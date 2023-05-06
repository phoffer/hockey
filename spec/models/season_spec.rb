require 'rails_helper'

RSpec.describe Season, type: :model do
  let(:season) { create(:season) }
  it "should have a valid factory" do
    assert season.valid?
  end
end

# == Schema Information
#
# Table name: seasons
#
#  id                 :bigint           not null, primary key
#  end_date           :date
#  regular_end_date   :date
#  regular_start_date :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  external_id        :string           not null
#
# Indexes
#
#  index_seasons_on_external_id  (external_id) UNIQUE
#
