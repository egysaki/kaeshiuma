class CreateHorses < ActiveRecord::Migration[5.1]
  def change
    create_table :horses do |t|
      t.string :name, null: false
      t.string :sex, null: false
      t.integer :age, null: false
      t.integer :active_status, null: false
      t.integer :hair_color_type, null: false
      t.date :birth_day, null: false
      t.integer :trainer_id
      t.integer :owner_id
      t.integer :producer_id
      t.integer :blood_line_id

      t.timestamps
    end
  end
end
