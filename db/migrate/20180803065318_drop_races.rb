class DropRaces < ActiveRecord::Migration[5.1]
  def change
    drop_table :race
  end
end
