class Season < ApplicationRecord
  has_many :games

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
