class ChangeColumnHairColorTypeOnHorses < ActiveRecord::Migration[5.1]
  def change
    change_column :horses, :hair_color_type, :string, null: false
  end
end
