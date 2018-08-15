class AddIndexRaceIdOnRaceInfos < ActiveRecord::Migration[5.1]
  def change
    add_index :race_infos, :race_id
  end
end
