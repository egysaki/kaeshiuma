class AddColumnMotherIdOnHorses < ActiveRecord::Migration[5.1]
  def change
    add_column :horses, :mother_id, :integer
  end
end
