class DropRaces < ActiveRecord::Migration[5.1]
  def change
    drop_table :races
  end
end
