class AddColumnFatherIdOnHorses < ActiveRecord::Migration[5.1]
  def change
    add_column :horses, :father_id, :integer
  end
end
