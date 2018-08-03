class CreateRace < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.string :name, null: false
      t.integer :distance, null: false
      t.integer :course_id, null: false
      t.string :grade, null: false

      t.timestamps
    end
  end
end
