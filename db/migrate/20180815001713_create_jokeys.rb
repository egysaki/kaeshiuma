class CreateJokeys < ActiveRecord::Migration[5.1]
  def change
    create_table :jokeys do |t|
      t.string :name

      t.timestamps
    end
  end
end
