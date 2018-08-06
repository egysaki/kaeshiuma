class AddColumnHorseRaceInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :horse_race_infos, :odds, :float
    add_column :horse_race_infos, :pace, :string
  end
end
