class CreateHorseRaceInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :horse_race_infos do |t|
      t.integer :horse_id, null: false
      t.integer :race_result_id, null: false
      t.integer :accompishment_time
      t.integer :time_for_3f
      t.integer :order_of_placing
      t.string :passing_info
      t.integer :weight
      t.integer :basis_weight
      t.integer :popularity
      t.integer :post_position
      t.integer :horse_number
      t.integer :margin

      t.timestamps
    end
  end
end
