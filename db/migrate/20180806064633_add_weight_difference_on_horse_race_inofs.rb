class AddWeightDifferenceOnHorseRaceInofs < ActiveRecord::Migration[5.1]
  def change
    add_column :horse_race_infos, :weight_difference, :string
  end
end
