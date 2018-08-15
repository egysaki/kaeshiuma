class AddIndexJokeyIdOnHorseRaceResults < ActiveRecord::Migration[5.1]
  def change
    add_index :horse_race_results, :jokey_id
  end
end
