class RenameHorseRaceInfosToHorseRaceResults < ActiveRecord::Migration[5.1]
  def change
    rename_table :horse_race_infos, :horse_race_results
  end
end
