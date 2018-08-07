class RenameRaceResultsToRaceInfos < ActiveRecord::Migration[5.1]
  def change
    rename_table :race_results, :race_infos
  end
end
