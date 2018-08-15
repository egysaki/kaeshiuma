class HorseRaceResult < ApplicationRecord
  belongs_to :horse
  belongs_to :race_info
  belongs_to :jokey
end
