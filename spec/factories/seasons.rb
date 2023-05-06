FactoryBot.define do
  factory :season do
    # the sequencing seems silly but this ensures non-overlapping seasons and reasonable dates if multiple are created for a single spec
    sequence(:external_id)        { |i| "#{2000+i}#{2001+i}" }
    sequence(:regular_start_date) { |i| "#{2000+i}-09-01" }
    sequence(:regular_end_date)   { |i| "#{2001+i}-04-15" }
    sequence(:end_date)           { |i| "#{2001+i}-06-30" }
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
