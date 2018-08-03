class CreateRaceResults < ActiveRecord::Migration[5.1]
  def change
    create_table :race_results do |t|
      t.integer :race_id, null: false
      t.string :corse_status
      t.date :event_date
      t.integer :times
      t.integer :race_round

      t.timestamps
    end
  end
end
