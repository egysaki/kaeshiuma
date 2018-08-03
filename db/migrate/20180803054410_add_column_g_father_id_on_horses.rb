class AddColumnGFatherIdOnHorses < ActiveRecord::Migration[5.1]
  def change
    add_column :horses, :g_father_id, :integer
  end
end
