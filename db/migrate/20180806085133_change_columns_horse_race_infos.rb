class ChangeColumnsHorseRaceInfos < ActiveRecord::Migration[5.1]
  def change
    change_column :horse_race_infos, :accomplishment_time, :string
    change_column :horse_race_infos, :margin, :float
  end
end
