class AddIndexHorseIdOnHorseRaceResults < ActiveRecord::Migration[5.1]
  def change
    add_index :horse_race_results, :horse_id
  end
end
