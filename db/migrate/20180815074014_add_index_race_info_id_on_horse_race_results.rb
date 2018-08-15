class AddIndexRaceInfoIdOnHorseRaceResults < ActiveRecord::Migration[5.1]
  def change
    add_index :horse_race_results, :race_info_id
  end
end
