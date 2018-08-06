class RaceResult < ApplicationRecord
  belongs_to :race

  has_many :horse_race_info
end
