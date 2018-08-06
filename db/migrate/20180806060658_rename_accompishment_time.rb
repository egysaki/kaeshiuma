class RenameAccompishmentTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :horse_race_infos, :accompishment_time, :accomplishment_time
  end
end
