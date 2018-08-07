class RenameColumnRaceResultIdToRaceInfoId < ActiveRecord::Migration[5.1]
  def change
    rename_column :horse_race_results, :race_result_id, :race_info_id
  end
end
