class AddColumnJokeyIdOnHorseRaceResults < ActiveRecord::Migration[5.1]
  def change
    add_column :horse_race_results, :jokey_id, :integer
  end
end
