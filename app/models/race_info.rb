class RaceInfo < ApplicationRecord
  belongs_to :race

  has_many :horse_race_results
end
