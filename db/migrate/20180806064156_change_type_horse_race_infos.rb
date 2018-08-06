class ChangeTypeHorseRaceInfos < ActiveRecord::Migration[5.1]
  def change
    change_column :horse_race_infos, :accomplishment_time, :float
    change_column :horse_race_infos, :time_for_3f, :float
    change_column :horse_race_infos, :basis_weight, :float
  end
end
